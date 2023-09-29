# My CLI Project

## Table of Contents

- [! Critical Discoveries](#!)
- [TODO](#todo)
- [Set Up](#set-up-repository)
- [Disable "Loading profiles took X ms" message](#disable-loading-profiles-took-x-ms-message)
- [Modules](#modules)
- [Changing Text Color](#changing-text-color)
- [Hash Tables](#hash-tables)
- [JSON Manipulation](#json-manipulation)
- [Cryptography (Encryption and Decryption)](#cryptography)
- [References](#references)

---

## ! CRITICAL DISCOVERIES

- `get-content x.json` DOES NOT RETURN A STRING.
  This interferes with encryption and decryption, making files undecipherable.
```powershell
  $notRaw = get-content      x.json
     $raw = get-content -raw x.json
  $notRaw.gettype().name   # outputs Object[]
  $raw.gettype().name      # outputs String
```
- The `echo` alias does not work with `-foregroundcolor`. Aliases are to be avoided

---

## Set Up Repository

Follow these steps:

`WIN` + `X` .. `I`
```powersehll
cd $profile\..\..
$pwd.path | scb
```
CTRL + ,  
On left hand side, GO TO 'PowerShell' 
GO TO 'Starting directory'  
CTRL + V  
'Save'  
Return to Terminal (WIN + X .. I)

```powershell
git clone https://github.com/CavalierAhmad/powershell
cd powershell
git switch baby  # Switch to desired branch (optional)
# Ready
```

---

## TODO

See TODO comments in profile

### Details

About frequency: when time runs out, create a copy of this task, but add frequency to deadline, reset status. As for the original, set as OVERDUE

##### CREATE

\> new-task # OR create
Title: _____     # if \$null, cancel
Deadline: ______ # if \$null, add 24 hours and set Status as "unscheduled"
	# example: aug,25,8  ==>  August 25th at 8 am
Repeatable? [Enter to skip or "n {D|M|Y}"]: _______  # if \$null, set as \$null
   1. APP
   2. FIN
   3. HOME
   4. BILL
   5. ACA
   6. CAR
   7. SPEC
Category 1-7: ______

TODO:
1. Generate new ID
2. Set title as received
3. Deadline
	3.1 Handle null case
	3.2 Parse String, call setDeadline
4. Parse frequency and return array
5. Set category as received or NONE if null
6. Save to JSON
7. Report to user

##### RETRIEVE

(On script load) Load ALL JSON into hashtable
(On script load) Convert hash to PSOB and display

> get/select <ID>  # Display info on specific task
> get/select *     # Calculates time remaining and display nicely formatted table

##### UPDATE

> update/set <ID> [-newid] [-t] [-d] [-f] [-s] [-c] [-p] [-done]
	[-newid] (replaces id)
	[-t] (change title, no compute)
	[-d] (change deadline, compute required)
	[-f] (change frequency, compute required)
	[-s] (change status, no computate)
	[-c] (change cat, no compute)
	[-p] (change priority, no usage yet)
	[-done] (set as complete)

##### DELETE

> delete/del <ID>

##### SPECIAL COMMANDS

finish <ID>  # same as update <ID> -done

---

## Disable "Loading profiles took X ms" message

To disable the "Loading profiles took X ms" message, go to [C:\Users\ahmad\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json](C:/Users/ahmad/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState)
(change `ahmad` to actual username)

Add **-nologo** to `"commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"`:
```json
    "profiles": 
    {
        "defaults": {},
        "list": 
        [
            {
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -nologo",
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "hidden": false,
                "name": "Windows PowerShell"
            },
```

---

## Modules

Creating a PowerShell module is a great way to encapsulate and share reusable functions, cmdlets, and resources. Here's a basic example of a simple PowerShell module:

Let's create a module named "MyModule" that contains a single custom function.

1. Create a new directory for your module, typically within your PowerShell modules directory. You can find your modules directory by running the command: `$env:PSModulePath`.

```powershell
# Navigate to the modules directory
cd $env:PSModulePath
# Create a directory for your module
New-Item -Name "MyModule" -ItemType "Directory"
# Navigate into the module directory
cd "MyModule"
```

2. Inside your module directory, create a new PowerShell script module file (`.psm1`) and name it `MyModule.psm1`. This file will contain your custom functions and cmdlets.

```powershell
# Create MyModule.psm1
New-Item -Name "MyModule.psm1" -ItemType "File"
```

3. Edit the `MyModule.psm1` file with your custom function. For this example, let's create a simple function called `Get-HelloWorld`.

```powershell
# MyModule.psm1
function Get-HelloWorld {
    Write-Host "Hello, World from MyModule!"
}
```

4. Save the file and exit the text editor.

5. Create a module manifest file (`.psd1`) for your module. This manifest file provides metadata and information about your module.

```powershell
# Create MyModule.psd1
New-ModuleManifest -Path "MyModule.psd1" -RootModule "MyModule.psm1"
```

6. Open the `MyModule.psd1` file with a text editor and add module information. At a minimum, you should specify the `ModuleVersion`, `Author`, and `Description`.

```powershell
# MyModule.psd1
@{
    ModuleVersion = '1.0'
    Author = 'Your Name'
    Description = 'A simple PowerShell module.'
}
```

7. Save the file and exit the text editor.

8. You can now import your module into your PowerShell session or scripts using the `Import-Module` cmdlet:

```powershell
Import-Module MyModule
```

9. Use your custom function from the module:

```powershell
Get-HelloWorld
```

That's it! You've created a basic PowerShell module with a custom function. You can continue to expand your module by adding more functions, cmdlets, and resources to make it more useful for your specific needs.

---

## Changing text color
**Examples:**

#### Using ANSI Escape Code

```powershell
# Customize the prompt
function prompt {
    $grey = [char]27 + '[90m'  # ANSI escape code for grey text color
    $reset = [char]27 + '[0m'  # ANSI escape code to reset text color

    if ($PWD.Path -eq $workspace) {
        "${grey}> ${reset}"
    } elseif ($PWD.Path -like "*\NEXUS\*") {
        $nexusPart = $PWD.Path -replace ".*\\NEXUS\\?", "NEXUS\"
        "${grey}$nexusPart> ${reset}"
    } elseif ($PWD.Path -like "*\NEXUS") {
        "${grey}\NEXUS> ${reset}"
# 🌱 <-- this emoji does not work on every machine
    } else {
        "${grey}$PWD`n> ${reset}"
    }
}
```
#### Using switches

```powershell
write-host -foregroundcolor Red    # For warning
write-host -backgroundcolor Yellow # For prompt
```

---

## Hash Tables

These are clever and useful uses of hash tables, read:

https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-hashtable?view=powershell-7.3

---

## JSON Manipulation

#### APPEND TO JSON

##### Example
*.json:*
```json
{
  "key1": {
    "subkey1": "string/number/boolean/{K:V}",
    "subkey2": null
  }
}
```

```powershell
$key = "unique"                                 # Create unique key
$val = @{subkey1 = "value" ; subkey2 = "value"} # Create new object respecting existing scopes
$json = cat .json                              # Import .json file
$hash = $json | convertfrom-json -ashashtable  # Convert JSON to hash table
$hash.add($key,$val)                           # Append new object to hash table
$json = $hash | convertto-json                 # Convert hash table to JSON
$json > .json                                  # Overwrite .json
```
##### Result
```json
{
  "key1": {
    "subkey1": "string/number/boolean/{K:V}",
    "subkey2": null
  },
  "key2": {
    "subkey1": "value",
    "subkey2": "value"
  }
}
```

#### DISPLAY JSON

##### Select all

```powershell
$hash = cat ".json" | convertfrom-json -ashashtable
$psob = $hash | convertto-psob         # Convert hashtable into custom objects
$psob | format-table -autoSize         # Display as table (optional)
```
```powershell
function converto-psob($hashtable){
    return $hashTable.GetEnumerator() | ForEach-Object { 
        [PSCustomObject]@{
            'Website' = $_.key
            'Username' = $_.Value.user
            'Password' = $_.Value.age
        }
    }
}
```

##### Select one

```powershell
$tmp = $psob | where {$_.key -eq "keyname"} # Select all in hashtable fulfilling criteria
$tmp | format-list                          # Display as list
```

#### UPDATE JSON

```powershell
$hash = cat ".json" | convertfrom-json -ashashtable
$hash.$key.$subkey = "new value"
$hash | convertto-json > .json
```

#### DELETE JSON

```powershell
$hash.remove('key1')
$hash | convertto-json > .json
```

---

## CRYPTOGRAPHY

##### Generate an AES key
```powershell
# GENERATING A KEY
$key = new-object byte[] 16 # Initialize a 16-byte key
$RNG = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
$RNG.getBytes($key)         # Generate array of 16 random bytes
$key > .\.key               # Store key, key is ready
```
##### ENCRYPT (Plaintext to Ciphertext)
```powershell
# ENCRYPTION
$plaintext = "secret to be encrypted"
$securestring = $plaintext | convertto-securestring -asplaintext -force
    # or user input: $securestring = read-host -assecurestring
$ciphertext = $securestring | convertfrom-securestring -key $key # LOCKED
$ciphertext > .\.encrypted                                       # Store ciphertext
```
##### DECRYPT (Ciphertext to Plaintext)
```powershell
# DECRYPTION
$ciphertext = cat .\.encrypted # Retrieve ciphertext and key
$securestring = $ciphertext | convertto-securestring -key $key # Cannot be UNLOCKED without proper key
$plaintext = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securestring))
```

#### Future improvement
Instead of using the key directly, use a derived key.
Derived key are obtained from a password which is more memorable.

**Learn more**:

> The key is too hard to memorize. Is there a way to generate the same key using a password?

Answer:

>Yes, you can derive an encryption key from a password using a process called "key derivation." The idea is to use a password to generate a cryptographic key that can be used for encryption and decryption. PowerShell provides a way to do this using a password-based key derivation function (PBKDF) and a salt value for added security.

>Here's how you can generate an encryption key from a password in PowerShell:

1. **Choose a Strong Password:**

   Start by choosing a strong and secure password that you can remember. The strength of the password is crucial for the security of the derived key.

2. **Generate a Salt:**

   A salt is a random value that is combined with the password to create variability in the derived key. This helps protect against attacks like rainbow tables. You should generate a unique salt for each use.

   ```powershell
   $salt = New-Object byte[] 16  # 16 bytes (128 bits) salt
   $rngCsp = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
   $rngCsp.GetBytes($salt)
   ```

3. **Derive the Key:**

   You can use the `Rfc2898DeriveBytes` class in PowerShell to derive the key from the password and salt using a PBKDF (e.g., PBKDF2). Here's an example:

   ```powershell
   $password = "YourStrongPassword"  # Replace with your password
   $iterations = 10000  # Number of iterations (adjust as needed)
   
   $keyDerivation = New-Object System.Security.Cryptography.Rfc2898DeriveBytes $password, $salt, $iterations
   $derivedKey = $keyDerivation.GetBytes(32)  # 32 bytes (256 bits) key
   ```

   In this example, `$iterations` represents the number of iterations used in the key derivation process. A higher number of iterations increases the computational effort required for key derivation and improves security.

4. **Use the Derived Key:**

   You can now use the derived key for encryption or decryption, such as with `ConvertTo-SecureString` and `ConvertFrom-SecureString`, as shown earlier in previous responses.

>Remember to securely store the salt value along with the derived key, as you'll need it when you want to derive the key again during decryption. Additionally, ensure that the password you choose is strong and that you follow best practices for password security.

>Key derivation from a password is a common technique for encrypting data with a user-supplied passphrase. It allows you to use something easier to remember (the passphrase) to derive a strong encryption key.

---

## References
[1] https://medium.com/@sumindaniro/encrypt-decrypt-data-with-powershell-4a1316a0834b
[2] https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-hashtable?view=powershell-7.3
[3] https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-clixml?view=powershell-7.3&viewFallbackFrom=powershell-7.1

---

For the far future, PowerShell GUI?

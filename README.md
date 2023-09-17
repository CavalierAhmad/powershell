## !

Do not use `echo` anymore, it does not work with `-foregroundcolor`

## TODO

https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-clixml?view=powershell-7.3&viewFallbackFrom=powershell-7.1

- [ ] After recently learning about hashtables and JSON, from now on, variables, cmds (list), tasks, bills, passwords, and more will be stored as JSON and loaded as HASH for manipulation
  - [x] Move variables to JSON
  - [x] Create script which convert .json to .ps1
  - [ ] Introduce CRUD to Bills
  - [ ] Introduce CRUD to passwords
- [ ] Create custom CRUD functions to accelerate hash-json convertions
- [x] **SecretsModule**: Learn to enrypt and decrypt passwords to be stored in json
- [ ] **BillsModule**: Imitate Excel
- [ ] **TasksModule**: Introduce CRUD to tasks
- [ ] Separate display procedure from loading procedure

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

## Set Up Repository

To clone this repo: `Win` + `X`, `I`
```shell
cd $home/Documents
git clone https://github.com/CavalierAhmad/powershell #Can skip next step if rename ths repo?
ren "powershell" "WindowsPowerShell" #Not tested
# git should be functional but test to make sure: git status
```

## Disable "Loading profiles took X ms" message

To disable the "Loading profiles took X ms" message, go to [C:\Users\ahmad\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json](C:/Users/ahmad/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState)

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

## Changing text color
**Examples:**
```powershell
write-host -foregroundcolor Red    # For warning
write-host -backgroundcolor Yellow # For prompt
```

## Hash Tables

These are clever and useful uses of hash tables, read:

https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-hashtable?view=powershell-7.3

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
$tmp = $psob | where {$_.website -eq "key"} # Select all in hashtable fulfilling criteria
$tmp | format-list                          # Display as list
```

#### UPDATE JSON

```powershell
$hash = cat ".json" | convertfrom-json -ashashtable
$hash['key1'].y = "new value"
$hash | convertto-json > .json
```

#### DELETE JSON

```powershell
$hash.remove('key1')
$hash | convertto-json > .json
```

## Encryption

TODO, see secrets module







---

For the far future, PowerShell GUI?
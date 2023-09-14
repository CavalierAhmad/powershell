# Starting path: $origin = "C:\Users\ahmad\Documents\PowerShell"

# Import variables from JSON, convert to hash
$hashtable = cat .\ressources\variables.json | ConvertFrom-Json -AsHashtable

# Initialize an empty script string
$scriptString = ""

# Iterate through each key-value pair in the hashtable
foreach ($key in $hashtable.Keys) {
    $value = $hashtable[$key]
    $scriptLine = "`$$key = `"$value`"" # Build the script line for the key-value pair
    echo $scriptLine
    $scriptString += "$scriptLine`n"    # Append the script line to the script string
}

$scriptString > .\ressources\run-variables.ps1     # Move script to script file
cat .\ressources\run-variables.ps1
. .\ressources\run-variables.ps1                   # Run that script
# Starting path: $origin = "C:\Users\ahmad\Documents\PowerShell"

# Locate variables
$vars = ".\ressources\variables.json"

# Import variables from JSON, convert to hash
$hashtable = cat $vars | ConvertFrom-Json -AsHashtable

# Initialize an empty script string
$scriptString = ""

# Iterate through each key-value pair in the hashtable
foreach ($key in $hashtable.keys) {
    $value = $hashtable[$key]           # Retrieve value associated to key
    $scriptLine = "`$$key = `"$value`"" # Build the script line for the key-value pair
    $scriptString += "$scriptLine`n"    # Append the script line to the script string
    echo $scriptLine
}

$scriptString > .\ressources\run-variables.ps1     # Move script string to script file
. .\ressources\run-variables.ps1                   # Run that script
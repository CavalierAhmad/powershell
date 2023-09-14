function build-variables {
    param (
        [hashtable] $hash
    )

    # Initialize an empty script string
    $scriptString = ""

    # Iterate through each key-value pair in the hashtable
    foreach ($key in $hash.Keys) {
        $value = $hash[$key]

        # Build the script line for the key-value pair
        $scriptLine = "`$$key = `"$value`""

        # Append the script line to the script string
        $scriptString += "$scriptLine`n"
    }

    # Output the final script string
    return $scriptString
}

# $json = ".\Documents\PowerShell\ressources\variables.json"
# $hash = cat $json | ConvertFrom-Json -AsHashtable

# # Usage
# $script = Build-ScriptFromHash -hash $hash

# # Output the generated script
# Write-Host -ForegroundColor Green "Generated Script:"
# Write-Host $script

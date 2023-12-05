# TODO: load vars from JSON
# TODO: invoke build-variables $hash
# TODO: Run variables loaded

function build-variables ([hashtable] $hash) {

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
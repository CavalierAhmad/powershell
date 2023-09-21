function newv ($name, $value) {
    if (-not $name){$name = listen "Enter variable: $"}
    if (-not $value){$value = listen "`$$name = "}
    $hash = cat ".\ressources\variables.json" | ConvertFrom-Json -AsHashtable
    $hash.add($name,$value)  # Save to hash
    $hash | ConvertTo-Json > ".\ressources\variables.json" # Save to JSON
    echo "`"$name`": `"$value`" was successfully added to variables.json"
    set-variable -name $name -value $hash[$name] -scope `"Global`"  `# To make it effective immediately
}

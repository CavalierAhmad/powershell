# Red for warning or error
# Yellow for inquiry

$passManager = "C:\Users\Ahmad\Documents\PowerShell\SecretsModule"
cd $passManager
cls

function get-pass ($hkey){
    # Load JSON
    $passwords = [ordered]@{}
    $passwords = cat "$passManager\.json" | ConvertFrom-Json -AsHashtable

    if (-not $hkey){
        $hkey = get-hkey $passwords
    }
    elseif (-not $passwords.containsKey($hkey)) {
        write-host "Invalid key." -ForegroundColor red
        $hkey = get-hkey $passwords
    }
}
function get-hkey($passwords){
    write-host "Which website?" -ForegroundColor Yellow
    write-host "-------------"  -ForegroundColor Yellow
    foreach ($k in $passwords.keys){Write-Host "  $k"}
    
    $keyIsValid = $false
    do {
        Write-Host "Select: " -BackgroundColor Yellow -NoNewline
        $hkey = Read-Host
        if (-not $passwords.containsKey($hkey)){write-host "Invalid key."}
        else {$keyIsValid = $true}
    } until ($keyIsValid)
    return $hkey
}
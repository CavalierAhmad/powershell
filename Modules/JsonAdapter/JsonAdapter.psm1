# JsonAdapter.psm1
# tested: operational

# $red = [char]27 + '[31m'  # ANSI escape code for grey text color
# $reset = [char]27 + '[0m'  # ANSI escape code to reset text color

function toJson ($hashtable) {
    if (-not ($hashtable -and $hashtable -is [ordered])){
        write-host "Specify [ordered] type. [hashtable] not accepted." -ForegroundColor red
        return "error"
    }
    return $hashtable | ConvertTo-Json
}

function fromJson ($string){
    if (-not $string) {
        Write-Host "Specify JSON [string] or filepath" -ForegroundColor Red
        return "error"
    }
    elseif (Test-Path $string) {
        try {
            $jsonContent = Get-Content -Path $string -Raw
            $hashtable = $jsonContent | ConvertFrom-Json -AsHashtable
            return $hashtable
        }
        catch {
            Write-Host "Invalid format! File content is not valid JSON" -ForegroundColor Red
            return "error"
        }
    }
    else {
        try {
            $hashtable = $string | ConvertFrom-Json -AsHashtable
            return $hashtable
        }
        catch {
            Write-Host "Invalid format! Input string is not valid JSON" -ForegroundColor Red
            return "error"
        }
    }
}

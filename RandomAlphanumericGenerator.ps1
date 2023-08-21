function Get-RandomAlphanumeric {
    $characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    $random = Get-Random -Minimum 0 -Maximum $characters.Length
    $firstByte = $characters[$random]

    $random = Get-Random -Minimum 0 -Maximum $characters.Length
    $secondByte = $characters[$random]

    return "$firstByte$secondByte"
}

# USAGE:
# $randomValue = Get-RandomAlphanumeric
# Write-Host "Random Alphanumeric Value: $randomValue"

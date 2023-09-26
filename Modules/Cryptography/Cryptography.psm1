# Cryptography.psm1

$1 = [char]27 + '[31m'  # ANSI escape code for red text color
$0 = [char]27 + '[0m'  # ANSI escape code to reset text color

function encrypt ($plaintext, $key) {
    if (-not ($plaintext)){
        Write-Host "Must pass plaintext string to encrypt!" -ForegroundColor Red
        return "${1}error${0}"
    }
    elseif (-not ($plaintext -is [string])){
        $type = $plaintext.gettype().name
        Write-Host "Must pass a $(u string)!! You passed a: $type" -ForegroundColor Red
        return "${1}error${0}"
    }
    if (-not $key){
        $key = cat $DOMAIN.paths.AESkey
        Write-Host "No key specified, using default key at `$DOMAIN.paths.AESkey" -ForegroundColor Yellow
    }
    $securestring = $plaintext | convertto-securestring -asplaintext -force
    $ciphertext = $securestring | convertfrom-securestring -key $key # LOCKED
    return $ciphertext
}

function decrypt ($ciphertext, $key) {
    if (-not $ciphertext){
        Write-Host "Must pass ciphertext to decrypt!" -ForegroundColor Red
        return "${1}error${0}"
    }
    #if ($ciphertext -is [byte[]]){Write-Host "Forgot to pass ciphertext, dumbass" -ForegroundColor Red ; return "${1}error${0}"}
    if (-not $key){
        $key = cat $DOMAIN.paths.AESkey
        Write-Host "No key specified, using default key at `$DOMAIN.paths.AESkey" -ForegroundColor Yellow
    }
    try {
        $securestring = $ciphertext | convertto-securestring -key $key -ErrorAction SilentlyContinue # Cannot be unlocked without proper key
        $plaintext = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securestring))
        return $plaintext
    }
    catch {
        write-host "Wrong key" -ForegroundColor Red
        return "${1}error${0}"
    }
}

function new-key {
    # GENERATING A KEY
    $key = new-object byte[] 16 # Initialize a 16-byte key
    $RNG = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
    $RNG.getBytes($key)         # Generate array of 16 random bytes
    write-host "16-byte key created"
    return $key
}
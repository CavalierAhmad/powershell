# # Red for warning or error
# # Yellow for inquiry

# function get-pass ($hkey){
#     # Fetch key
#     $keyLocation = "C:\Users\Ahmad\OneDrive - Algonquin College\NEXUS\z~MISC"
#     $key = cat "$keyLocation\.key"

#     # Load JSON
#     $passwords = [ordered]@{}
#     $passwords = cat "$passManager\.json" | ConvertFrom-Json -AsHashtable

#     # Get valid hashtable key
#     if (-not $hkey){
#         $hkey = get-hkey $passwords
#     }
#     elseif (-not $passwords.containsKey($hkey)) {
#         write-host "Invalid key." -ForegroundColor red
#         $hkey = get-hkey $passwords
#     }

#     # Decrypt password
#     $securepass = $passwords[$hkey]["pass"] | ConvertTo-SecureString -Key $key
#     $tmphash = @{
#         URL=$passwords[$hkey]["url"]
#         Username=$passwords[$hkey]["user"]
#         Password=[System.Runtime.InteropServices.Marshal]::PtrToStringBSTR([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securepass))
#         Note=$passwords[$hkey]["note"]
#     }

#     #display
#     $passwords | format-table # TODO REMOVE
#     write-host "`<`< $hkey `>`>" -foregroundcolor green -nonewline
#     $passwords["$hkey"] | format-table
#     $tmphash | format-table

#     #initiate interaction
#     start-main-menu $hkey $passwords
# }
# function get-hkey($passwords){
#     write-host "Which website?" -ForegroundColor Yellow
#     write-host "-------------"  -ForegroundColor Yellow
#     foreach ($k in $passwords.keys){Write-Host "$k"}
    
#     $keyIsValid = $false
#     do {
#         Write-Host "Select: " -BackgroundColor Yellow -NoNewline
#         $hkey = Read-Host
#         $hkey = $hkey.Trim().ToLower() # clean input
#         if (-not $passwords.containsKey($hkey)){write-host "Invalid key."}
#         else {$keyIsValid = $true}
#     } until ($keyIsValid)
#     return $hkey
# }

# function start-main-menu ($hkey, $passwords){
#     write-host "`n[E] edit`t[ENTER] exit loop`n`>" -ForegroundColor Yellow -nonewline
#     $valid = $false
#     do {
#         $s = Read-Host
#         $s = $s.Trim().ToLower() # clean input
#         if (-not ($s -eq 'e' -or [string]::IsNullOrWhiteSpace($s))){
#             write-host "Invalid.`n`>" -ForegroundColor red -NoNewline
#         } else {$valid = $true}
#     } until ($valid)

#     if ($s -eq 'e'){start-edit-menu $hkey $passwords}
# }

# function start-edit-menu ($hkey, $passwords){
#     write-host "[A] url [U] user [P] password [N] note [ENTER] exit`n`>" -ForegroundColor Yellow -nonewline
#     do {
#         $s = Read-Host
#         $s = $s.Trim().ToLower() # clean input
#         if (-not ($s -eq 'a' -or $s -eq 'u' -or $s -eq 'p'-or $s -eq 'n' -or [string]::IsNullOrWhiteSpace($s))){
#             write-host "Invalid.`n`>" -ForegroundColor red -NoNewline
#         } else {
#             if ($s -eq 'a'){
#                 $url = read-host -Prompt "URL"
#                 modify "url" $url $hkey $passwords
#                 start-edit-menu $hkey $passwords
#             }
#             if ($s -eq 'u'){
#                 $user = read-host -Prompt "Username"
#                 modify "user" $user $hkey $passwords
#                 start-edit-menu $hkey $passwords
#             }
#             if ($s -eq 'p'){
#                 $pass = read-host -AsSecureString -Prompt "Pass"
#                 modify "pass" $pass $hkey $passwords
#                 start-edit-menu $hkey $passwords
#             }
#             if ($s -eq 'n'){
#                 $note = read-host -Prompt "Note"
#                 modify "note" $note $hkey $passwords
#                 start-edit-menu $hkey $passwords
#             }
#             if ([string]::IsNullOrWhiteSpace($s)){$exit = $true}
#         }
#     } until ($exit)
# }

# function modify ($option, $data, $hkey, $passwords) {
#     if (-not ($option -eq "pass")){
#         $passwords[$hkey][$option] = $data
#         $passwords | ConvertTo-Json > .json
#         # for viewing only
#             $tmphash = @{
#                 URL=$passwords[$hkey]["url"]
#                 Username=$passwords[$hkey]["user"]
#                 Password=[System.Runtime.InteropServices.Marshal]::PtrToStringBSTR([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securepass))
#                 Note=$passwords[$hkey]["note"]
#             }
#             $tmphash
#     }
#     if ($option -eq "pass"){
#         $keyLocation = "C:\Users\Ahmad\OneDrive - Algonquin College\NEXUS\z~MISC"
#         $key = cat "$keyLocation\.key"
#         $ciphertext = $data | convertfrom-securestring -Key $key
#         $passwords[$hkey]["pass"] = $ciphertext
#         $passwords | convertto-json > .json
#         # for viewing only
#             $tmphash = @{
#                 URL=$passwords[$hkey]["url"]
#                 Username=$passwords[$hkey]["user"]
#                 Password=[System.Runtime.InteropServices.Marshal]::PtrToStringBSTR([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($data))
#                 Ciphertext=$ciphertext
#                 Note=$passwords[$hkey]["note"]
#             }
#             $tmphash
#     }
# }
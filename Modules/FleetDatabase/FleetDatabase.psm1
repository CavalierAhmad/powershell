#TODO LAST INSPECTION

#TODO DISPLAY MAINTENANCE TABLE

#TODO DISPLAY LIFESPANS
function new-report {
    display "documents"
    display "maintenance"
    display "lifespans"
}

function display ($request) {
    if ($request -eq "documents"){
        $documents = fromjson "C:\Users\Ahmad\Documents\PowerShell\Modules\FleetDatabase\hyundaiDocs.json"
        $table = @()
        foreach ($doc in $documents.keys){
            # 1. Extract document name, display as is
            # 2. Extract number, display as is as is
            # 3. Extract expiration
                # Convert to date
                #Display formatted
                # Compute expiration - now
                # Format result

            # Flush values
            $docName = $docNumber = $expiration = $status = $null

            # Document name
            $docName = $documents.$doc.docName

            # Document number
            $docNumber = $documents.$doc.number

            # Document expiration date
            $expirationString = $documents.$doc.expiration

            # Attempting to convert expiration string to date
            try { 
                if ($null -eq $expirationString){
                    $expiration = (fgr "missing")}
                else {
                    $expiration = (new-date $expirationString)              # To use in computations
                    $expirationString = $expiration.ToString("yyyy MMM d")  # To use in display
                }
            } 
            catch {
                $expiration = (fgr "Modules/Fleet*/display()")
            }

            # Attempt to take difference between today and expiration date
            try { 
                $diff = ($expiration - (get-date)).days  # Difference in days
                # format according to length < 45 is yellow, < 14 is red
                    if ($diff -le 14){$status = (fgr "$($diff) days left")}
                elseif ($diff -le 45){$status = (fgy "$($diff) days left")}
                else                 {$status =      "$($diff) days left" }
            }
            catch {
                $status = (fgr "error")
            }

            # Cells are ready, now create row
            $tableRow = [PSCustomObject]@{
                Document = $docName
                Number = $docNumber
                Expiration = $expirationString
                Status = $status
            }

            # Append to table
            $table += $tableRow
        }

        # Display table
        $table | Format-Table -wrap
        
        # Output: Last SAAQ inspection done on <date> (<diff> days ago)
        $lastInspection = new-date $documents.inspection.lastInspection
        $diff = [math]::Round(((get-date) - $lastInspection).days / 30.437)
        Write-Host "Last SAAQ inspection done on" (u $lastInspection.ToString("yyyy MMM d")) "($($diff) months ago)"
    }
    if ($request -eq "maintenance"){

    }
    if ($request -eq "lifespans"){

   }
}
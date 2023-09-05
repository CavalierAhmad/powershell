# This function adds a new task to the array
function add {
    param(
        [string]$title,      # Task description
        [DateTime]$deadline, # Deadline
        [array]$frequency,   # Number, Temporal Unit
        [int]$category       # Category number
    )

    # Initialize $status
    $status = "Not started"

    # Handle $title
    if (-not $title){
        $title = Read-Host "What is the task"
        if ([string]::IsNullOrWhiteSpace($title)) {
            Write-Host "Operation canceled."
            return $null
        }
    }

    # Handle $deadline
    if (-not $deadline){
        $rawDate = Read-Host "Deadline ['(yyyy,((mmm,dd),hh))']"
        $rawDate = $rawDate.ToUpper()
        # If prompt is skipped, use default deadline of today + 24 hours
        if ([string]::IsNullOrWhiteSpace($rawDate)) {
            $deadline = (get-date).AddDays(1)
            $status = "Unscheduled"
        } else {
            # Allowed formats for datetime
            $formats = @("yyyy,MMM,dd", "MMM,dd,HH", "MMM,dd")
            $parsedDeadline = $null
            
            # Try all the formats until one fits
            foreach ($format in $formats){
                if ([DateTime]::TryParseExact($rawDate, $format, [CultureInfo]::InvariantCulture, 0, [ref]$parsedDeadline)){
                    $deadline = $parsedDeadline
                    break
                }
            }

            # Handle invalid format
            if (-not $formatFound) {
                Write-Host "Invalid date format. Deadline remains unset."
                $status = "unscheduled"
            }
        }
    }

    # Handle $frequency
    if (-not $frequency) {
        $ans = Read-Host "Repeatable? [Y/N]"
        if ([string]::IsNullOrWhiteSpace($ans) -or $ans -eq "n") {$frequency = $null}
        else {
            $frequency[0] = Read-Host "  Repeat every <number> <T-unit>`n               ********         "
            $frequency[1] = Read-Host "  Repeat every $($frequency[0]) <T-unit>`n                        ********" 
        }
    }

    # Handle $category
    if (-not $category) {
        $category = Read-Host "1. APP`n2. FIN`n3. HOME`n4. BILL`n5. ACA`n6. CAR`n7. SPEC`n8. NONE (default)"
        if ($category -lt 1 -or $category -gt 8) {$category = 8}
    }

    # Create task object as a PSCustomObject
    $task = buildTask $title $deadline $frequency $category $status
    write-host $task

    # Send to JSON

    # return for debugging
    return $task
}

function buildTask ($title,$deadline,$frequency,$category,$status) {

    if ($frequency -eq $null) {$frequency = @("","")}
    $categories = @('APP','FIN','HOME','BILL','ACA','CAR','SPEC','NONE')

    switch ($frequency[1]){
        "d" {$unit = "days"}
        "m" {$unit = "months"}
        "y" {$unit = "years"}
        default {$unit = ""}
    }

    $task = [PSCustomObject]@{
        ID = (generate2ByteID)
        Title = $title
        Deadline = $deadline
        Frequency = "$($frequency[0]) $unit"
        Status = $status
        Category = $categories[$category-1]
        Completed = $null
    }

    return $task
}

function generate2ByteID() {
    $characters = "ABCDEFGHIJKLMNPQRSTUVWXYZ0123456789"

    $random = Get-Random -Minimum 0 -Maximum $characters.Length
    $firstByte = $characters[$random]
    $random = Get-Random -Minimum 0 -Maximum $characters.Length
    $secondByte = $characters[$random]

    return "$firstByte$secondByte"
}
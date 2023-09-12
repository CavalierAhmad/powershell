# This function adds a new task to the array
function add {
    param(
        [string]$title,      # Task description
        [DateTime]$deadline, # Deadline
        [array]$frequency,   # Number, Temporal Unit
        [int]$category       # Category number
    )

    # TODO: Collect user input
    # TODO: Validate
    # TODO: Add to array
    # TODO: Initialize task
    # TODO: Send to JSON
    # TODO: return to add to array

    # Initialize array
    $validInput = @()

    # Get title
    if (-not $title){
        $raw = Read-Host "What is the task"
        $validInput += _validateTitle $raw
    }

    # Get deadline
    if (-not $deadline){
        $raw = Read-Host "Enter year (default:$((get-date).Year))"
        $validInput += _validateYear $raw
        $raw = Read-Host "Enter month (default:$((get-date).Month))"
        $validInput += _validateMonth $raw
        $raw = Read-Host "Enter day (default:tomorrow)"
        $validInput += _validateDay $raw
    }

    # Get frequency if applicable
    if (-not $frequency) {
        $raw = Read-Host "Repeatable? [Y/N]"
        if ([string]::IsNullOrWhiteSpace($raw) -or $ans -eq "n") {
            $validInput += 0
            $validInput += $null}
        else {
            $raw = Read-Host "Enter frequency [int {d/m/y}]"
            $frequency = _validateFrequency $raw
            $validInput += $frequency[0]
            $validInput += $frequency[1]
        }
    }

    # Get category
    if (-not $category) {
        $raw = Read-Host "0. NONE (default)`n1. APP`n2. FIN`n3. HOME`n4. BILL`n5. ACA`n6. CAR`n7. SPEC`n"
        $validInput += _validateCategory $raw
    }

    # Create task object as a PSCustomObject
    $task = buildTask $validInput
    write-host $task

    # Send to JSON

    # return for debugging
    return $task
}

function _validateTitle($title){
    if ([string]::IsNullOrWhiteSpace($title)) {
        Write-Host "Operation canceled."
        return $null
    }
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

# function select ()    {} # displays all tasks
# function select ($id) {} # display single task with expanding menu
# function update ($id) {}
# fuintion delete ($id) {}
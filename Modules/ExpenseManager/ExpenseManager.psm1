# TODO: REPORT
<#
new-report "expenses" redirects here.
new-report() calls display() which calls new-viewtable()
which generates a "plain table", and a "stylish table".
STATUS:
calculate-rates    TESTED
calculate-timeLeft TESTED
transform OK
add-style TESTED for single
new-viewTable(): Stylish table only displays X01 and X04, most likely because of unexpected types
#todo resolve edge cases
#>

function debug {open .\Modules\ExpenseManager}

<#
FUNCTION CHART:
new-report
    display
        new-viewtable
            transform
                calculate-rates
                calculate-timeLeft
            add-style
            aggregate
#>

function new-report {
    display "expenses"
    #display "raw table"
    display "legend"
    display "options"
}

# Routing function
function display ($request) {
    if ($request -eq "expenses"){
        new-viewTable | Format-Table -wrap
    }    
    if ($request -eq "raw table"){
        Write-Host (u (fgw "`nRAW TABLE"))
        $table = cat -raw "C:\Users\Ahmad\Documents\PowerShell\Modules\ExpenseManager\expenses.json" | ConvertFrom-Json
        $table | format-table -Wrap
    }
}

<#
Imports JSON file and automatically converts to an array of PS objects, aka a table.
new-viewtable() iterates thru the json-imported table and transform() each into a plainRow.
Then adds the plainRow to a plainTable for aggregation. Then it adds style to the plainRow and
adds that row to "stylishTable" for display
When done creating the plain table, measure sums and minimums and add-style to that row
and finally, add that row to the stylish table.
Return the stylish table.
#>
function new-viewTable { # TODO

    $rawTable = cat -raw "C:\Users\Ahmad\Documents\PowerShell\Modules\ExpenseManager\expenses.json" | ConvertFrom-Json
    $plainTable = @()
    $stylishTable = @()

    foreach ($row in $rawTable){
        # transform raw row to plain row
        $plainRow = transform $row
        # add row to plain table
        $plainTable += $plainRow
        $plainTable
        # pass row to style function
        $stylishRow = add-style $plainRow $false
        # add stylish row to stylish table
        $stylishTable += $stylishRow
    }

    #todo $stylishTable += (add-padding $stylishTable)
    #todo $aggregateRow = add-style (aggregate $plainTable)
    #todo $stylishTable += $aggregateRow
    
    return $stylishTable
}
function legend {echo "legend placeholder"}
function options {echo "options plaeholder"}

function transform ($row) { # TESTED
    # calculate rates and return an array of integers
    $rates = calculate-rates $row.amount $row.frequency
    # calculate time difference and receive a hashtable 
    $timeLeft = calculate-timeLeft $row.nextPayment $row.finalPayment
    
    return [PSCustomObject]@{
        ID = $row.id
        name = $row.name
        monthly = $rates[0] #a
        biweekly = $rates[1] #a
        daily = $rates[2] #a
        deltaNext = $timeLeft.deltaNext
        deltaFinal = $timeLeft.deltaFinal
        Status = $row.status
        Source = $row.source
        nextPayment = $row.nextPayment # min
        finalPayment = $row.finalPayment
        isVariable = $row.isVariable
    }
}

<# Adds colors and decorations to a given row.
The "aggregate" switch controls whether it is dealing with a regular row or an aggregate row
#>
function add-style ($plainRow, $aggregate) { # TODO

    if ($aggregate){

        # $stylishRow = ...
 
    } else {

        # Need to process the following, everything else displayas is
            $rates = @($plainRow.Monthly,$plainRow.Biweekly,$plainRow.Daily)
            $timeTilNext = $plainRow.deltaNext
            $timeTilFinal = $plainRow.deltaFinal
            $status = $plainRow.status

        # Monthly, Biweekly, Daily: If isVariable is true, rates trio are italics
            if (-not ($rates[0] -is [double])){
                $rates[0] = $rates[0]
                $rates[1] = $rates[1]
                $rates[2] = $rates[2]
            }
            else {
                $rates[0] = [math]::Round($rates[0])
                $rates[1] = [math]::Round($rates[1])
                $rates[2] = [math]::Round($rates[2])
                
                if ($plainRow.isVariable){
                    $rates[0] = "$(i $rates[0])" + "$"
                    $rates[1] = "$(i $rates[1])" + "$"
                    $rates[2] = "$(i $rates[2])" + "$"
                } else {
                    $rates[0] = "" + $rates[0] + "$"
                    $rates[1] = "" + $rates[1] + "$"
                    $rates[2] = "" + $rates[2] + "$"
                }
            }
        
        # Time Left: If Time left has certain criteria, give color or display hours instead of day    
            switch ($timeTilNext[1]<#unit#>) {
                "d" {
                        if ($timeTilNext[0] -le 2)  {$timeString = (fgr "$($timeTilNext[0])  ")}
                    elseif ($timeTilNext[0] -le 5)  {$timeString = (fgo "$($timeTilNext[0])  ")}
                    elseif ($timeTilNext[0] -le 8)  {$timeString = (yellowish-orange "$($timeTilNext[0])  ")}
                    elseif ($timeTilNext[0] -le 14) {$timeString = (fgy "$($timeTilNext[0])  ")}
                    elseif ($timeTilNext[0] -le 21) {$timeString = (light-green "$($timeTilNext[0])  ")}
                    elseif ($timeTilNext[0] -gt 21) {$timeString = (fgg "$($timeTilNext[0])  ")}
                }
                "h" {$timeString = "$(f $(bgr $(fgy $timeTilNext[0])))"} # hh:mm h
                "error" {}
                Default {return (fgr "error")}
            }

            # If finalPayment is not null nor a string, append "/diff" to timeleft

            if ($timeTilFinal -and -not ($timeTilFinal -is [string])){
                $timeString = $timeString + "$(gray "/$($timeTilFinal[0])$($timeTilFinal[1])")"
            }

        # Status = $plainRow.Status (array)
            $stylishStatus = @()
            foreach ($item in $status){
                switch ($item) {
                    "NP" {$newitem = (fgr $item)}
                    "NSEC" {$newitem = (fgr $item)}
                    "NCOM" {$newitem = (fgr $item)}
                    "P" {$newitem = (fgg $item)}
                    "SEC" {$newitem = (fgg $item)}
                    "COM" {$newitem = (fgg $item)}
                    Default {$newitem = $item}
                }
                $stylishStatus += $newitem
            }

        # "Final P." = $plainRow.finalPayment.ToString("yyyy-MMM-d")
            if ($timeTilFinal -is [string] -or $timeTilFinal -eq $null){
                $finalP = $timeTilFinal
            } else {
                $finalP = $plainRow.finalPayment.ToString("yyyy-MMM-d")
            }
        
        # Build the row to return
            $stylishRow = [PSCustomObject]@{
                ID = $plainRow.ID
                "Name of Bill" = $plainRow.name
                Monthly = $rates[0]
                Biweekly = $rates[1]
                Daily = $rates[2]
                "Time Left" = (n $timeString)
                Status = $stylishStatus
                Source = $plainRow.Source
                Deadline = $plainRow.nextPayment.ToString("MMM-d")
                "Final P." = $finalP
            }
    }

    return $stylishRow
}

# Returns an array of three amounts: monthly, biweekly, daily
# done
function calculate-rates ($amount, $frequency) { # partially-tested
    if (-not ($amount -and $frequency)){return @((fgr "error"),(fgr "error"),(fgr "error"))}
    $u = $frequency.unit
    $n = $frequency.number
    $daysPerYear = 365.25             # 1 y = 365.25   d
    $fortnightsPerYear = 365.25 / 14  # 1 y =  26.0893 f
    $fortnightsPerMonth = 2.17        # 1 m =   2.17   f
    $daysPerMonth = [System.DateTime]::DaysInMonth((Get-Date).Year, (Get-Date).Month)
    $rates = @(0,0,0)
    if ($u -eq 'y'){
        $rates[0] = $amount / ($n * 12)                  # 1 y = 12.0000 months
        $rates[1] = $amount / ($n * $fortnightsPerYear)  # 1 y = 26.0893 fortnights
        $rates[2] = $amount / ($n * $daysPerYear)        # 1 y = 365.250 days
    }
    elseif ($u -eq 'm'){
        $rates[0] = $amount /  $n
        $rates[1] = $amount / ($n * $fortnightsPerMonth)
        $rates[2] = $amount / ($n * $daysPerMonth)
    }
    elseif ($u -eq 'd'){ # TESTED
        $rates[0] = $amount * $daysPerMonth / $n
        $rates[1] = $amount * 14           / $n
        $rates[2] = $amount               / $n
    }
    else {
        return "Invalid frequency @ calculate-rates"
    }

    return $rates
}

# Receives the next deadline and the final deadline.
# Outputs a hashtable containing the difference between today and the next deadline
# in number of days, or hours if less than a day, or minutes if less than an hour.
# As for final deadline, follow same logic. It is optional.
function calculate-timeLeft ($date1, $date2) {
    if (-not $date1){return (fgr "error")}

    # Process next payment date
    try {
        # Assume difference in days non-zero
        $diff = ($date1 - (get-date))
        if ($diff.days -ne 0)
             {$nextDiff = @($diff.days,'d')}
        else {$nextDiff = @($diff.totalHours,'h')}
    }
    catch {$nextDiff = @(-99999,(fgr "error"))}

    # Process last payment date
    # date2 can be a date OR a string
    try {
        if ($date2 -is [string] -or $date2 -eq $null){
            if ($date2 -eq "indefinite"){$lastDiff = $null}
            else {$lastDiff = $date2} # Keep string as is
        } else {
            $diff = ($date2 - (get-date))
                if ($diff.days -gt 548){$lastDiff = @([math]::Round($diff.days/365,1),'y')}    # Over 1.5 years
            elseif ($diff.days -gt 182){$lastDiff = @([math]::Round($diff.days/30.437,1),'m')} # Over 6 months
            else                       {$lastDiff = @($diff.days,'d')}
        }
    }
    catch {$lastDiff = @(-99999,(fgr "error"))}
        
    return @{
        deltaNext = $nextDiff  <#An array of value and unit#>
        deltaFinal = $lastDiff <#Either an array or string#>
    }
}
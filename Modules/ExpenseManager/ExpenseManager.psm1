# TODO: REPORT
<#
new-report "expenses" redirects here.
new-report() calls display() which calls new-viewtable()
which generates a "plain table", and a "stylish table".
STATUS:
calculate-rates    TESTED
calculate-timeLeft TESTED
#>

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
    display "raw table"
    display "legend"
    display "options"
}

# Routing function
function display ($request) {
    if ($request -eq "expenses"){
        $viewTable = new-viewTable
        $viewTable | Format-Table -wrap
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
        # pass row to style function
        $stylishRow = add-style $plainRow $false
        # add stylish row to stylish table
        $stylishTable += $stylishRow
    }

    $aggregateRow = add-style (aggregate $plainTable)
    $stylishTable += $paddingRow
    $stylishTable += $aggregateRow
    
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
 
    } else { # TODO TEST

        $deltaFinal = $plainRow."Time Left".deltaFinal[0] # [number,unit]
        $deltaNext = $plainRow."Time Left".deltaNext[0]
        $deltaNextUnit = $plainRow."Time Left".deltaNext[1]
        $monthly = $biweekly = $daily = $plainRow.Monthly # WRONG

        # If isVariable, rates trio are italics
        if ($plainRow.isVariable){
            $monthly  = "$(i $plainRow.Monthly)"
            $biweekly = "$(i $plainRow.Biweekly)"
            $daily    = "$(i $plainRow.Daily)"
        }
        # If Time left has certain criteria, give color or display hours instead of day
            
        switch ($deltaNextUnit) {
            "d" {
                    if ($deltaNext -le 2){$deltaNext = "$(fgr $deltaNext)"}
                elseif ($deltaNext -le 5) {$deltaNext = "$(fgo $deltaNext)"}
                elseif ($deltaNext -le 8) {$deltaNext = "$(yellowish-orange $deltaNext)"}
                elseif ($deltaNext -le 14) {$deltaNext = "$(fgy $deltaNext)"}
                elseif ($deltaNext -le 21) {$deltaNext = "$(light-green $deltaNext)"}
                elseif ($deltaNext -gt 21) {$deltaNext = "$(fgg $deltaNext)"}
            }
            "h" {$deltaNext = "" + $deltaNext + "h"}
            "m" {}
            Default {return (fgr "error")}
        }

        # If finalPayment is not null, append "/diff" to timeleft

        if ($deltaFinal){$deltaNext = "" + $deltaNext + "  /$deltaFinal"}

        $stylishRow = [PSCustomObject]@{
            ID = $plainRow.ID
            "Name of Bill" = $plainRow."Name of Bill"
            Monthly = $monthly
            Biweekly = $biweekly
            Daily = $daily
            "Time Left" = $deltaNext
            Status = $plainRow.Status
            Source = $plainRow.Source
            Deadline = $plainRow.Deadline.ToString("MMM-d")
            "Final Deadline" = $plainRow."Final Deadline".ToString("yyyy-MMM-d")
        }

        return $stylishRow
    }
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
        $rates[0] = $amount / $n
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

    try {
        $diff = ($date1 - (get-date)).days
        $unit = 'd'

        if ($diff -eq 0){$diff = ($date1 - (get-date)).hours ; $unit = 'h'}
        # if ($diff -eq 0){$diff = ($date1 - (get-date).minutes)}

        $diff2 = ($date2 - (get-date)).days
        
        return @{
            deltaNext = @($diff,$unit)
            deltaFinal = @($diff2,"d")
        }
    }
    catch {
        return (fgr "error")
    }
}
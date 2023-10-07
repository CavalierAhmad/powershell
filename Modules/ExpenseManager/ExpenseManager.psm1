# See #todo below

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
        "Name of Bill" = $row.name
        Monthly = $rates[0] #a
        Biweekly = $rates[1] #a
        Daily = $rates[2] #a
        "Time Left" = $timeLeft
        Status = $row.status
        Source = $row.source
        Deadline = $row.nextPayment # min
        "Final Deadline" = $row.finalPayment
        isVariable = $row.isVariable
    }
}

# Adds colors and decorations to a given row.
# The "aggregate" switch controls whether it is dealing with a regular row or an aggregate row
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


########## OLD CODE

# 
# # view-report done
# #     new-report done
# #         create-dataset 
# #             transform done
# #                 get-rates done
# #                 get-diff done
# #             convertto-PSO 
# #         merge-dataset 
# #         apply-style
# # DONE


# # Loads expenses array from JSON, stores it in $domain.expenses, "expenses" being the key
# function load-expenses {
#     $hash = fromjson $domain.json.expenses
#     $domain.add("expenses",$hash.expenses)
#     log 'Loaded expenses to DOMAIN from JSON'
# }

# # Loads income array from JSON, stores it in $domain.income, "income" being the key
# function load-income {
#     $hash = fromJson $DOMAIN.json.expenses
#     $DOMAIN.add("income",$hash.income)
# }

# function view-report {
#     log 'FUNCTION: view-report'
#     $report = ExpenseManager\new-report # returns ordered hash
#     Write-Host $report.title
#     $report.table | format-table
#     log 'EXIT: view-report'
# }

# function new-report {
#     log 'FUNCTION: new-report'
#     $array = $DOMAIN.expenses
#     $dataset = ExpenseManager\create-dataset $array        # Returns a plain table and hashtable of aggregate results
#     $plainTable = ExpenseManager\merge-dataset $dataset    # Combines plain table with aggregate results
#     $stylishTable = ExpenseManager\apply-style $plainTable # Returns a beautified table along a legend

#     $report = [ordered]@{
#         title = "${u}EXPENSES${u0}"
#         table = $stylishTable
#     }
#     log "RETURN TO CALLER: new-report"
#     return $report
# }

# # This functions receives an array of expense hashtables and
# # converts it into a table via an array of PSObject as well
# # a hashtable with containing aggregate information.
# function create-dataset ($arrayOfExpenses) {
#     log 'FUNCTION: create-dataset'
#     $table = @()
#     $data = @{m=@();b=@();d=@()}
#     $stats = @{m=$null;b=$null;d=$null}

#     foreach ($rawHashtable in $arrayOfExpenses){
#         $processedHashtable = ExpenseManager\transform $rawHashtable # add rates and time diff
#         $data.m += $processedHashtable.monthly
#         $data.b += $processedHashtable.biweekly
#         $data.d += $processedHashtable.daily
#         $plainRow = ExpenseManager\convertto-PSO $processedHashtable # convert hashtable to table row
#         $table += $plainRow                                          # add row to table
#     }

#     # Measure amount stats for each time unit
#     $stats.m = $data.m | Measure-Object -AllStats
#     $stats.b = $data.b | Measure-Object -AllStats
#     $stats.d = $data.d | Measure-Object -AllStats

#     log "RETURN TO CALLER" 
#     return [ordered]@{
#         plainTable = $table
#         stats = $stats
#     }
# }

# # Receives a basic hashtable and adds additional info
# function transform ($hash) {
#     $rates = get-rates $hash.amount $hash.frequency
#     $timeDiff = get-diff $hash.date
#     $hash.add("monthly",$rates[0])
#     $hash.add("biweekly",$rates[1])
#     $hash.add("daily",$rates[2])
#     $hash.add("timeDiff",$timeDiff)
#     return $hash
# }

# # Returns the time difference between today and deadline
# function get-diff ($deadline) {
#     if ($deadline -eq $null){return $null}
#     else {
#         $today = Get-Date
#         $diff = New-TimeSpan -Start $today -End $deadline
#         return $diff
#     }
# }

# function merge-dataset ($dataset) {
#     blink "merged dataset"
#     return "merged dataset"
# }

# function apply-style ($plainTable) {
#     return "applied style"
# }

# function convertto-PSO ($hashtable){
#     $diff = $hashtable.timeDiff
#     $t
#     $unit = ""
#         if ($diff.Days -ne 0){$t = $diff.Days ; $unit = ""}
#     elseif ($diff.Hours -ge 0){$t = $diff.Hours ; $unit = (fgr "hours")}
#     elseif ($diff.Minutes -ge 0){$t = $diff.Minutes ; $unit = (fgr "minutes")}
#     else   {$t = $diff.Days ; $unit = ""}
#     $pso = [PSCustomObject]@{
#         ID = $hashtable.id
#         Name = $hashtable.name
#         Monthly = $hashtable.monthly
#         # $roundedDouble = [math]::Round($originalDouble, 2)
#         Biweekly = $hashtable.biweekly
#         Daily = $hashtable.daily
#         "Time Remaining" = "" + $t + $unit
#         Deadline = $hashtable.date.ToString("MMM-dd")
#         Status = $hashtable.status
#         Source = $hashtable.source
#         "Is Variable?" = $hashtable.isVariable
#         "f" = "" + $hashtable.frequency.number + $hashtable.frequency.unit
#     }
#     return $pso
# } 

# function format-PSO ($plainPSO) {}
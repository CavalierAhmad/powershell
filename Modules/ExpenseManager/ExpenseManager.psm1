# TODO
# view-report done
#     new-report done
#         create-dataset #todo
#             transform done
#                 get-rates done
#                 get-diff done
#             convertto-PSO #todo
#         merge-dataset #todo
#         apply-style #todo
# DONE


# Loads expenses array from JSON, stores it in $domain.expenses, "expenses" being the key
function load-expenses {
    $hash = fromjson $domain.json.expenses
    $domain.add("expenses",$hash.expenses)
    log 'Loaded expenses to DOMAIN from JSON'
}

# Loads income array from JSON, stores it in $domain.income, "income" being the key
function load-income {
    $hash = fromJson $DOMAIN.json.expenses
    $DOMAIN.add("income",$hash.income)
}

function view-report {
    log 'FUNCTION: view-report'
    $report = ExpenseManager\new-report # returns ordered hash
    Write-Host $report.title
    $report.table | format-table
    log 'EXIT: view-report'
}

function new-report {
    log 'FUNCTION: new-report'
    $array = $DOMAIN.expenses
    $dataset = ExpenseManager\create-dataset $array        # Returns a plain table and hashtable of aggregate results
    $plainTable = ExpenseManager\merge-dataset $dataset    # Combines plain table with aggregate results
    $stylishTable = ExpenseManager\apply-style $plainTable # Returns a beautified table along a legend

    $report = [ordered]@{
        title = "${u}EXPENSES${u0}"
        table = $stylishTable
    }
    log "RETURN TO CALLER: new-report"
    return $report
}

# This functions receives an array of expense hashtables and
# converts it into a table via an array of PSObject as well
# a hashtable with containing aggregate information.
function create-dataset ($arrayOfExpenses) {
    log 'FUNCTION: create-dataset'
    $table = @()
    $data = @{m=@();b=@();d=@()}
    $stats = @{m=$null;b=$null;d=$null}

    foreach ($rawHashtable in $arrayOfExpenses){
        $processedHashtable = ExpenseManager\transform $rawHashtable # add rates and time diff
        $data.m += $processedHashtable.monthly
        $data.b += $processedHashtable.biweekly
        $data.d += $processedHashtable.daily
        $plainRow = ExpenseManager\convertto-PSO $processedHashtable # convert hashtable to table row
        $table += $plainRow                                          # add row to table
    }

    # Measure amount stats for each time unit
    $stats.m = $data.m | Measure-Object -AllStats
    $stats.b = $data.b | Measure-Object -AllStats
    $stats.d = $data.d | Measure-Object -AllStats

    log "RETURN TO CALLER" 
    return [ordered]@{
        plainTable = $table
        stats = $stats
    }
}

# Receives a basic hashtable and adds additional info
function transform ($hash) {
    $rates = get-rates $hash.amount $hash.frequency
    $timeDiff = get-diff $hash.date
    $hash.add("monthly",$rates[0])
    $hash.add("biweekly",$rates[1])
    $hash.add("daily",$rates[2])
    $hash.add("timeDiff",$timeDiff)
    return $hash
}

# Returns an array of three amounts: monthly, biweekly, daily
function get-rates ($amount, $frequency) {
    $n = $frequency.number
    $u = $frequency.unit
    if ($u -eq 'm'){
        $biweekly = $amount / 2.17 # Average biweekly cycle per month
        $daily = $amount / [System.DateTime]::DaysInMonth((Get-Date).Year, (Get-Date).Month)
        return @($amount, $biweekly, $daily)
    }
    elseif ($u -eq 'd'){
        $monthly  = $amount / $n * 30.436 # average days per month
        $biweekly = $amount / $n * 14     # 14 days per biweekly cycle
        $daily    = $amount / $n
        return @($monthly,$biweekly,$daily)
    }
    else {
        return "Invalid frequency @ process-amount"
    }
}

# Returns the time difference between today and deadline
function get-diff ($deadline) {
    if ($deadline -eq $null){return $null}
    else {
        $today = Get-Date
        $diff = New-TimeSpan -Start $today -End $deadline
        return $diff
    }
}

function merge-dataset ($dataset) {
    blink "merged dataset"
    return "merged dataset"
}

function apply-style ($plainTable) {
    return "applied style"
}

function convertto-PSO ($hashtable){
    $diff = $hashtable.timeDiff
    $t
    $unit = ""
        if ($diff.Days -ne 0){$t = $diff.Days ; $unit = ""}
    elseif ($diff.Hours -ge 0){$t = $diff.Hours ; $unit = (fgr "hours")}
    elseif ($diff.Minutes -ge 0){$t = $diff.Minutes ; $unit = (fgr "minutes")}
    else   {$t = $diff.Days ; $unit = ""}
    $pso = [PSCustomObject]@{
        ID = $hashtable.id
        Name = $hashtable.name
        Monthly = $hashtable.monthly
        # $roundedDouble = [math]::Round($originalDouble, 2)
        Biweekly = $hashtable.biweekly
        Daily = $hashtable.daily
        "Time Remaining" = "" + $t + $unit
        Deadline = $hashtable.date.ToString("MMM-dd")
        Status = $hashtable.status
        Source = $hashtable.source
        "Is Variable?" = $hashtable.isVariable
        "f" = "" + $hashtable.frequency.number + $hashtable.frequency.unit
    }
    return $pso
} 

function format-PSO ($plainPSO) {}
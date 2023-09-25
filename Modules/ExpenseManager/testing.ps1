# Force current dir
$path = "C:\Users\Ahmad\Documents\PowerShell\BillsModule"
cd $path
pwd

# JSON
$json = '{
    "B00": {
        "name": "Car Payment",
        "frequency": { "num": 14, "unit": "d" },
        "amount": 199.22,
        "deadline": "2023-09-18",
        "status": "Auto",
        "expenseType": "Personal",
        "isVariable": false,
        "source": "Cheque"
    },
    "B09": {
        "name": "Other Payment",
        "frequency": { "num": 14, "unit": "d" },
        "amount": 199.22,
        "deadline": "2023-09-18",
        "status": "Auto",
        "expenseType": "Personal",
        "isVariable": true,
        "source": "Cheque"
    }
}'

# Load Script
$hash = $json | convertfrom-json -AsHashtable

# Make it human readable
$table = @()
foreach ($key in $hash.keys) {
    $value = $hash[$key]
    # Build PS Custom Object
    $psob = [PSCustomObject]@{
        Id = $key
        Name = $hash[$key]['name']
        Frequency = "Every $($hash[$key]['frequency']['num']) $($hash[$key]['frequency']['unit'])"
        Amount = $hash[$key]['amount']
        Deadline = $hash[$key]['deadline']
        Status = $hash[$key]['status']
        Type = $hash[$key]['expenseType']
        Variable = $hash[$key]['isVariable']
        Source = $hash[$key]['source']
    }
    $table += $psob
}

# Display table
$table | format-table

# Update table
$select = $hash['B09']
$select.add("ID",'B-09')
$select
class Bill {
    [string]$name
    [array]$frequency
    [decimal]$amount
    [datetime]$deadline
    [string]$status
    [string]$expenseType
    [bool]$isVariable
    [string]$source
}

function add-bill {
    param (
        [string]$name,
        [array]$frequency,
        [decimal]$amount,
        [datetime]$deadline,
        [string]$status,
        [string]$expenseType,
        [bool]$isVariable,
        [string]$source
    )

    $b = [PSCustomObject]@{
        Name = $name
        Frequency = $frequency
        Amount = $amount
        Deadline = $deadline
        Status = $status
        ExpenseType = $expenseType
        IsVariable = $isVariable
        Source = $source
    }

    if (-not $b.name){$b.name = Read-Host "Name of Bill"}
    if (-not $b.frequency){$b.frequency = get-frequency}
    if (-not $b.amount){$b.amount = get-amount}
    if (-not $b.deadline){$b.deadline = get-deadline}
    if (-not $b.status){$b.status = get-status}
    if (-not $b.expenseType){$b.expenseType = get-expenseType}
    if (-not $b.isVariable){$b.isVariable = get-isVariable}
    if (-not $b.source){$b.source = get-source}

    return $b
}

function get-frequency {
    while ($true) {
        $input = Read-Host "Enter frequency (e.g., 3 d, 2 m, 1 y)"

        # Use regex to match valid input patterns
        if ($input -match '^\s*(\d+)\s*(d|m|y)\s*$') {
            $number = [int]$matches[1]
            $unit = $matches[2].Substring(0, 1).ToLower()  # Get the first letter
            
            # Ensure the number is greater than 0
            if ($number -gt 0) {return @($number,$unit)}
        }

        # Invalid input, prompt again
        Write-Host "Invalid input. Please enter a valid frequency."
    }
}
function get-amount{
    while ($true) {
        write-host -nonewline "Amount: $"
        $input = Read-Host

        # Try to parse the input as a decimal
        if ([decimal]::TryParse($input, [ref]$amount) -and $amount -gt 0) {
            return $amount
        }

        # Invalid input, prompt again
        Write-Host "Invalid input. Please enter a valid positive number."
    }
}
function Get-Deadline {
    write-host "Enter deadline, (enter to skip);"
    $y = read-host "Year"  # year as int
        if ($y -isnot [int]){$y = (get-date).year ; echo "invalid, set to $y"} 

}


function get-status{}
function get-expenseType{}
function get-isVariable{}
function get-source{}

while($true){
    $y = get-deadline
echo $y
}

$x = add-bill
echo $x
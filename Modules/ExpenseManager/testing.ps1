function test-new-viewtable {}
function test-transform-row {}
function test-add-style-row {}
function test-add-style-agg {}
function test-calculate-rates {}
function test-calculate-timeLeft {} 

$rawTable = cat -raw "C:\Users\Ahmad\Documents\PowerShell\Modules\ExpenseManager\expenses.json" | ConvertFrom-Json
$row = $rawTable[0]
$plainRow = transform $row
$stylishRow = add-style $plainRow

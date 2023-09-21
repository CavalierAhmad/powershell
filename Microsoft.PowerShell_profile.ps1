### PowerShell Profile Script

# Set the working directory
$origin = "$profile\.."
Set-Location $origin

Import-Module .\Modules\JsonAdapter

# Load JSON settings, calling it "DOMAIN" similarly to "environment"
$DOMAIN = cat .\config.json | ConvertFrom-Json -AsHashtable

echo "Loading variables..."
. $DOMAIN.paths.json.variables
echo "Loading aliases..."         ; . ".\ressources\aliases"
echo "Loading functions..."       ; . ".\ressources\functions"
echo "Loading banner..."          ; . ".\ressources\banner"
echo "Importing task modules..."  ; . ".\TaskModule"
# echo " Creating array # size = 35^2
# echo " Loading tasks into array
# echo " Loading tasklist header

# Set UI

# Set console title
$Host.UI.RawUI.WindowTitle = "MyTerminal" # from json 

# Set console color
$Host.UI.RawUI.BackgroundColor = "Black" # from json
$Host.UI.RawUI.ForegroundColor = "DarkYellow" # from json

# TODO: Put these in display.ps1

## BEGIN DISPLAY (control speed with boolean)

cls

# Display banner
slowbanner # Display banner

# Display datetime
$date = get-date -format "dddd, MMMM d, yyyy"
$time = get-date -format "hh:mm tt"
echo "`nTODAY IS: $date $time";wait

# Display tasklist header
echo "`nPENDING TASKS (make pretty table):";wait
echo "          Task     |   Time Left    ";wait
echo "    --------------------------------`n";wait

# Display tasks
. ".\ressources\tasklist"  # change to ./printtasks using iteration

echo "`nType 'cmds' to view common commands, 'newv' to add variable:`n"

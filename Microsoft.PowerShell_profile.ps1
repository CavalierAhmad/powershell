### PowerShell Profile Script

# Set the working directory
cd "$profile\.."
$origin = $PWD.Path

# Modules
Import-Module .\Modules\AssignmentManager\AssignmentManager.psm1 # TO DO           last
Import-Module .\Modules\BillManager\BillManager.psm1             # TODO PRIORITY
Import-Module .\Modules\ChoreManager\ChoreManager.psm1           # TO DO           low
Import-Module .\Modules\Colors\Colors.psm1                       # TO DO           low 
Import-Module .\Modules\CommonFunctions\CommonFunctions.psm1     # TO DO           med
Import-Module .\Modules\CredentialManager\CredentialManager.psm1 # TODO           high
Import-Module .\Modules\Cryptography\Cryptography.psm1
Import-Module .\Modules\EventManager\EventManager.psm1           # TODO           high
Import-Module .\Modules\JsonAdapter\JsonAdapter.psm1
Import-Module .\Modules\TaskManager\TaskManager.psm1             # TO DO           med
Import-Module .\Modules\UserInputProcessor\UserInputProcessor.psm1

# Load DOMAIN, which represents the environment data of this powershell session
$DOMAIN = fromjson .\config.json

# Import DOMAIN variables and aliases
. .\Scripts\import-variables
. .\Scripts\import-aliases
# Import JSON files
. .\Scripts\import-assignments # academic and udemy
. .\Scripts\import-bills       # bills, revenu, and expenses
. .\Scripts\import-chores      # house
. .\Scripts\import-events      # work schedule, regular transits, birthdays, document expiration
. .\Scripts\import-tasks       # one-time tasks and errands

# Set UI settings
$Host.UI.RawUI.WindowTitle = $DOMAIN.consoleSettings.windowTitle # "MyTerminal" from json
$Host.UI.RawUI.BackgroundColor = $DOMAIN.consoleSettings.backgroundColor
$Host.UI.RawUI.ForegroundColor = $DOMAIN.consoleSettings.foregroundColor

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

echo "`nType 'cmds' to view common commands, 'newv' to add variable:`n"
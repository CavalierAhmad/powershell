### PowerShell Profile Script

# Set the working directory
cd "$profile\.."
$origin = $PWD.Path

# Create log file
$logFile = ".\tmp\script.log"
"START _profile.ps1" > $logFile
function log ($log) {$log >> $logFile}

# Modules
Import-Module .\Modules\AssignmentManager\AssignmentManager.psm1 -verbose # TO DO           last
Import-Module .\Modules\ChoreManager\ChoreManager.psm1           -verbose # TO DO           low
Import-Module .\Modules\CredentialManager\CredentialManager.psm1 -verbose # TODO           high
Import-Module .\Modules\Cryptography\Cryptography.psm1           -verbose # Adequate
Import-Module .\Modules\EventManager\EventManager.psm1           -verbose # TODO           high
Import-Module .\Modules\ExpenseManager\ExpenseManager.psm1       -verbose # TODO PRIORITY
Import-Module .\Modules\FleetDatabase\FleetDatabase.psm1                  # Adequate: report hyundai
Import-Module .\Modules\HomeData\HomeData.psm1                            # Empty
Import-Module .\Modules\IncomeManager\IncomeManager.psm1         -verbose # Empty?
Import-Module .\Modules\InputControl\InputControl.psm1           -verbose #
Import-Module .\Modules\JsonAdapter\JsonAdapter.psm1             -verbose #
Import-Module .\Modules\StorageManager\StorageManager.psm1                #
Import-Module .\Modules\StyleModule\StyleModule.psm1             -verbose # Functional; to use style: "no style $(f "with style")"
Import-Module .\Modules\TaskManager\TaskManager.psm1             -verbose # TO DO           med
Import-Module .\Modules\UserInputProcessor\UserInputProcessor.psm1 -verbose
log 'Imported modules'

# Load DOMAIN, which represents the environment data of this powershell session
$DOMAIN = fromjson .\config.json ; log 'Loaded config'

#todo MOVE THESE INTO MODULES
. .\Scripts\import-variables   # DOMAIN variables
. .\Scripts\import-aliases
. .\Scripts\import-functions
. .\Scripts\import-assignments # academic and udemy
. .\Scripts\import-expenses    # expenses
. .\Scripts\import-chores      # house
. .\Scripts\import-events      # work schedule, regular transits, birthdays, document expiration
# . .\Scripts\import-tasks     # one-time tasks and errands
log 'Imported .\Scripts'

# Set UI settings
$Host.UI.RawUI.WindowTitle = $DOMAIN.consoleSettings.windowTitle # "MyTerminal" from json
$Host.UI.RawUI.BackgroundColor = $DOMAIN.consoleSettings.backgroundColor
$Host.UI.RawUI.ForegroundColor = $DOMAIN.consoleSettings.foregroundColor
log 'Set UI'

# Welcome user
. .\Scripts\welcome.ps1
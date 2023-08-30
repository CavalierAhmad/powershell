### PowerShell Profile Script

# TODO: Separate display procedure from loading procedure
# TODO: Nest display-procedure inside function taking 1 boolean para for controlling display speed
# TODO: After each command, rerun the script function but with speed limiter off for instant load
# TODO: Introduce color schema
# For the far future, PowerShell GUI?

# Set the working directory
Set-Location "$profile\.."

echo "Loading variables..."       ; . ".\variables"
echo "Loading aliases..."         ; . ".\aliases"
echo "Loading functions..."       ; . ".\functions"
echo "Loading banner..."          ; . ".\banner"
. ".\Task.ps1"
# echo " Creating array # size = 35^2
# echo " Loading tasks into array
# echo " Loading tasklist header

# Set console title
$Host.UI.RawUI.WindowTitle = "MyTerminal"

# Set console color
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "DarkYellow"

## BEGIN DISPLAY (control speed with boolean)

cls

# Display banner
slowbanner # Display banner

# Display datetime
echo "`nTODAY IS: $date $time";wait

# Display tasklist header
echo "`nPENDING TASKS (make pretty table):";wait
echo "          Task     |   Time Left    ";wait
echo "    --------------------------------";wait
# Display tasks
. ".\tasklist"  # change to ./printtasks using iteration

echo "`nType 'cmds' to view common commands, 'newv' to add variable:`n"

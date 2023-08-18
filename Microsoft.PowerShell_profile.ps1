### PowerShell Profile Script

# TODO: Separate display procedure from loading procedure
# TODO: Nest display-procedure inside function taking 1 boolean para for controlling display speed
# TODO: After each command, rerun the script function but with speed limiter off for instant load
# TODO: Introduce color schema
# For the far future, PowerShell GUI?

# Set the working directory
Set-Location "$profile\.."

. ".\variables"   # Load variables
. ".\aliases"     # Load aliases
. ".\functions"   # Load functions
. ".\banner"      # Load banner
# . ".\tasklist"  # Load tasks 

# Set console title
$Host.UI.RawUI.WindowTitle = "MyTerminal"

# Set console color
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Green"

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

echo "`nTo view commands, type viewcmd:`n"

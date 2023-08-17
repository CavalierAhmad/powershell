### PowerShell Profile Script

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
echo "`nTODAY IS: $date $time`n";wait

# Display tasklist header
echo "PENDING TASKS (make pretty table):";wait
echo "          Task     |   Time Left    ";wait
echo "    --------------------------------";wait
# Display tasks
. ".\tasklist"  # change to ./printtasks using iteration

echo "To view commands, type viewcmd:`n"

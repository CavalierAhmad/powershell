##### PowerShell Profile Script

########### LIST ALL VARS HERE

# MyTerminal version
	$version = "1.0"

# Set the working directory
	$workspace = split-path $profile -parent;
	Set-Location $workspace

# Load other variables
	. ".\variables"
	$sleeptime = 60 # Set output speed for dramatic effect

# Load aliases
	. ".\aliases"
	nal open "saps"

# Load functions
	. ".\functions"
	function wait {sleep -Milliseconds $sleeptime}

# Set console title
$Host.UI.RawUI.WindowTitle = "MyTerminal"

# Set console color
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Green"

# Display banner
. ".\banner.ps1"
slowbanner # Display banner

# Display datetime
$date = get-date -format "dddd, MMMM d, yyyy"
$time = get-date -format "hh:mm tt"
echo "`nTODAY IS: $date $time`n";wait

# Load tasks
echo "PENDING TASKS (make pretty table):"

echo "          Task     |   Time Left    "
echo "    --------------------------------"
. ".\tasklist.ps1";wait

echo "To view commands, type viewcmd:`n"

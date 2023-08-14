##### PowerShell Profile Script

# MyTerminal version
$version = "1.0"

# Set the working directory
$workspace = "$HOME\Documents\PowerShell"
Set-Location $workspace

# Set console title
$Host.UI.RawUI.WindowTitle = "MyTerminal"

# Set console color
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Green"

# Set output speed for dramatic effect
$sleeptime = 60
function wait {sleep -ms $sleeptime}

# Load banner
. ".\banner.ps1"
slowbanner

get-date;wait

# Load tasks
. ".\tasklist.ps1";wait

echo "To view commands, type viewcmd:"

# Load commands
. ".\commands.ps1"

function clr {cls ;
fastbanner
get-date
. ".\tasklist.ps1"
echo "To view commands, type viewcmd:"
}


# Customize the prompt
function prompt {
    if ($PWD.Path -eq $workspace) {
        "⌨️> "
    } elseif ($PWD.Path -like "*\NEXUS\*") {
        $nexusPart = $PWD.Path -replace ".*\\NEXUS\\?", "NEXUS\"
        "🌱 $nexusPart> "
    } elseif ($PWD.Path -like "*\NEXUS") {
        "🌱 NEXUS> "
    } else {
        "$PWD> "
    }
}

# Function to add a new function definition
function AddCmd {
    param(
        [string]$FunctionName,
        [string]$FunctionScript,
        [string]$FunctionDescription = "No description"
    )

    Add-Content -Path "commands.ps1" -Value "`nfunction $FunctionName { $FunctionScript }"
    Write-Host "Function '$FunctionName' added."
}

# Function to list all functions with descriptions
function viewcmd {
    $functions = Get-Content -Path "commands.ps1" | Select-String -Pattern "^function\s(.+?)\s\{(.+?)\}$" -AllMatches

    clr
    foreach ($function in $functions.Matches) {
        $functionName = $function.Groups[1].Value
        $functionDescription = "No description"

        if ($function -match "#\sDescription:\s(.+)$") {
            $functionDescription = $matches[1]
        }

        Write-Host "$functionName   ->   $functionDescription"
    }
	echo @"
*************************
To add:    addcmd
To modify: modcmd
"@
}

function modcmd {notepad "$workspace\commands.ps1"}

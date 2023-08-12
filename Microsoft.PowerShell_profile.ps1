##### PowerShell Profile Script

# variables
$workspace = "$HOME\Documents\PowerShell"


# Set the working directory
Set-Location $workspace

# Set console title
$Host.UI.RawUI.WindowTitle = "My Custom Terminal"

# Set console color
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Green"

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


# Load aliases
. ".\commands.ps1"

# Display Macros loaded message
echo "Commands loaded."

# Display Pending Tasks section
echo " __      __        __                                "
echo "/  \    /  \ ____ |  |   ____   ____   _____   ____  "
echo "\   \/\/   // __ \|  | _/ ___\ / __ \ /     \_/ __ \ "
echo " \        /\  ___/_  |__  \___(  \_\ )  | |  \  ___/_"
echo "  \__/\__/  \___  /____/\___  /\____/|__|_|  /\___  /"
echo "                \/          \/             \/     \/ "

echo ""
echo "To list commands:   listcmd"
echo "To add commands:    addcmd"
echo "To modify commands: modcmd"

echo ""
echo "Pending Tasks:"
echo "----------------"
echo "[1] Task 1 - COBOL Project 3"
echo ""
echo "What would you like to do?"
echo ""


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
function ListCmd {
    $functions = Get-Content -Path "commands.ps1" | Select-String -Pattern "^function\s(.+?)\s\{(.+?)\}$" -AllMatches

    foreach ($function in $functions.Matches) {
        $functionName = $function.Groups[1].Value
        $functionDescription = "No description"

        if ($function -match "#\sDescription:\s(.+)$") {
            $functionDescription = $matches[1]
        }

        Write-Host "$functionName   ->   $functionDescription"
    }
}

function modcmd {notepad "$workspace\commands.ps1"}

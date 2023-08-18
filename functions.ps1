function upload ($message) {clr ; git add . ; git commit -am "$message" ; git push ; git status}
function save ($key, $value) {"`$$key = `"$value`"" >> $variables}
function greet { echo "Hello World" }
function home {cd $workspace}
function nexus { cd "C:\Users\Ahmad\ONEDRI~1\NEXUS"}
function java {cd "C:\Users\Ahmad\ONEDRI~1\NEXUS\ACADEMIC\LEVEL 3\*JAVA"}
function cobol {cd "C:\Users\Ahmad\ONEDRI~1\NEXUS\ACADEMIC\LEVEL 3\*COB*"}
function mobile {cd "C:\Users\Ahmad\ONEDRI~1\NEXUS\ACADEMIC\LEVEL 3\*MOB*"}
function systems {cd "C:\Users\Ahmad\ONEDRI~1\NEXUS\ACADEMIC\LEVEL 3\*SYS*"}
function network {cd "C:\Users\Ahmad\ONEDRI~1\NEXUS\ACADEMIC\LEVEL 3\*NET*"}
function clr {cls ;
	fastbanner
	get-date
	. ".\tasklist.ps1"
	echo "To view commands, type viewcmd:"
}

# Customize the prompt
function prompt {
    if ($PWD.Path -eq $workspace) {
        "\> "
    } elseif ($PWD.Path -like "*\NEXUS\*") {
        $nexusPart = $PWD.Path -replace ".*\\NEXUS\\?", "NEXUS\"
        "$nexusPart> "
    } elseif ($PWD.Path -like "*\NEXUS") {
        "\NEXUS> "
	# 🌱 <-- this emoji does not work on every machine
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

function modcmd {notepad "$workspace\functions.ps1"}
function wait {sleep -Milliseconds $sleeptime}
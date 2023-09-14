function listen ($prompt) {
    Write-Host $prompt -NoNewLine
    return $Host.UI.ReadLine()
}

function cmds {
    echo @"
Command      Action
-------      -------
home         Return to workspace, home of mother script
tasks        List tasks, can specify category: ACA, HOME, BILL, CAR, APPT, ...
open         Alias for start-process, executes file or folder
nexus        Go to NEXUS, root folder in ONEDRIVE
newV         Adds a new variable permanently, alias: addv
getV         List only user-defined variables
gv           List all environment variables
modV         Opens list of variables for modification
upload       Adds, commits, and pushes repo to GitHub
create       Creates a task
update       Updates a task
delete       Deletes a task
ref          Refresh profile to load new variables

THIS COMMAND DOES NOT UPDATE AUTOMATICALLY
For a detailed list:
*** `> open `$functions
"@
}

function ref {. $profile}

function bills {cd $bills ; ls}

function newv ($variableName, $value) {
    if (-not $variable){$variable = listen "Enter variable: $"}
    if (-not $value){$value = listen "`$$variable = "}
    $name = $variable # duplicate
    "`$$variable = `"$value`"" >> $variables  # To make it persist accross sessions and devices
    echo "`$$variable = `"$value`" was successfully added to `$variables."
    set-variable -name $variable -value $value -scope 'Global'  # To make it effective immediately
}

function getv {cat $variables}

function upload ($message) {
	echo "git add"
	git add .
	echo "commit"
	git commit -am "$message"
	echo "git push"
	git push
	echo "Status:"
	git status
}
function greet { echo "Hello World" }
function home {cd $workspace}
function nexus { cd "C:\Users\Ahmad\ONEDRI~1\NEXUS"}
function clr {cls ;
	fastbanner
	get-date
	. ".\tasklist.ps1"
	echo "To view commands, type viewcmd:"
}

# Customize the prompt
function prompt {
    if ($PWD.Path -eq $workspace) {
        "`n> "
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

function wait {sleep -Milliseconds $sleeptime}

function build-variables ([hashtable] $hash) {

    # Initialize an empty script string
    $scriptString = ""

    # Iterate through each key-value pair in the hashtable
    foreach ($key in $hash.Keys) {
        $value = $hash[$key]

        # Build the script line for the key-value pair
        $scriptLine = "`$$key = `"$value`""

        # Append the script line to the script string
        $scriptString += "$scriptLine`n"
    }

    # Output the final script string
    return $scriptString
}
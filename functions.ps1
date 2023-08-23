function listen ($prompt) {
    Write-Host $prompt -NoNewLine
    return $Host.UI.ReadLine()
}

function commands {
    echo @"
Command      Action
-------      -------
home         Return to workspace, home of mother script
tasks        List tasks, can specify category: ACA, HOME, BILL, CAR, APPT, ...
open         Alias for start-process, executes file or folder
nexus        Go to NEXUS, root folder in ONEDRIVE
newV         Adds a new variable permanently, alias: addv
getV         List all vriables
modV         Opens list of variables for modification
upload       Adds, commits, and pushes repo to GitHub
create       Creates a task
update       Updates a task
delete       Deletes a task
THIS COMMAND DOES NOT UPDATE AUTOMATICALLY
For a detailed list:
*** `> open `$functions
"@
}

function newv ($variableName, $value) {
    if (-not $variable){$variable = listen "Enter variable: $"}
    if (-not $value){$value = listen "`$$variable = "}
    $name = $variable # duplicate
    "`$$variable = `"$value`"" >> $variables  # To make it persist accross sessions and devices
    echo "`$$variable = `"$value`" was successfully added to `$variables."
    set-variable -name $variable -value $value -scope 'Global'  # To make it effective immediately
}

# This function creates a new task
function create {
    param(
        [string]$title,
        [DateTime]$deadline,
        [string]$frequency, # N,T
        [TaskCategory]$category
    )

    $task = [Task]::new("placeholder")

    # Handle $title
    if (-not $title){
        $title = Read-Host "Enter task name"
        if ([string]::IsNullOrWhiteSpace($title)) {
            Write-Host "Operation canceled."
            return $null
        }
    }

    # Handle $deadline
    if (-not $deadline){
        $rawDate = Read-Host "Deadline ['(yyyy,((mmm,dd),hh))']"
        # If prompt is skipped, use default deadline of today + 24 hours
        if ([string]::IsNullOrWhiteSpace($rawDate)) {
            $deadline = (get-date).AddDays(1)
            $task.setStatus("unscheduled")
        } else {
            # Allowed formats for datetime
            $formats = @("yyyy,MMM,dd", "MMM,dd,HH", "MMM,dd")
            $parsedDeadline = $null
            
            # Try all the formats until one fits
            foreach ($format in $formats){
                if ([DateTime]::TryParseExact($rawDate, $format, [CultureInfo]::InvariantCulture, 0, [ref]$parsedDeadline)){
                    $deadline = $parsedDeadline
                    break
                }
            }

            # Handle invalid format
            if (-not $formatFound) {
                Write-Host "Invalid date format. Deadline remains unset."
                $task.setStatus("unscheduled")
            }
        }
    }

    # Handle $frequency

    # Handle $category
    
    return $task
}
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
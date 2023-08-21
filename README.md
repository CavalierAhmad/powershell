To cloning this repo: `Win` + `X`, `I`
```shell
cd $home/Documents
git clone https://github.com/CavalierAhmad/powershell #Can skip next step if rename ths repo?
ren "powershell" "WindowsPowerShell" #Not tested
# git should be functional but test to make sure: git status
```

To disable the "Loading profiles took X ms" message, go to [C:\Users\ahmad\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json](C:/Users/ahmad/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState)

Add **-nologo** to `"commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"`:
```json
    "profiles": 
    {
        "defaults": {},
        "list": 
        [
            {
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -nologo",
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "hidden": false,
                "name": "Windows PowerShell"
            },
```

About frequency: when time runs out, create a copy of this task, but add frequency to deadline, reset status. As for the original, set as OVERDUE

CREATE

> new-task # OR create
Title: _____     # if $null, cancel
Deadline: ______ # if $null, add 24 hours and set Status as "unscheduled"
	# example: aug,25,8  ==>  August 25th at 8 am
Repeatable? [Enter to skip or "n {D|M|Y}"]: _______  # if $null, set as $null
   1. APP
   2. FIN
   3. HOME
   4. BILL
   5. ACA
   6. CAR
   7. SPEC
Category 1-7: ______

TODO:
0. Insert overloop listening for ENTER
1. Generate new ID
2. Set title as received
3. Deadline
	3.1 Handle null case
	3.2 Parse String, call setDeadline
4. Parse frequency and return array
5. Set category as received or NONE if null
6. Save to JSON
7. Report to user

RETRIEVE

(On script load) Load ALL JSON into key-val set? key is id
(On script load) Generate header, iterate over array, and display table

> get/select <ID>  # Display info on specific task
> get/select *     # Calculates time remaining and display nicely formatted table

UPDATE

> update/set <ID> [-newid] [-t] [-d] [-f] [-s] [-c] [-p] [-done]
	[-newid] (replaces id)
	[-t] (change title, no compute)
	[-d] (change deadline, compute required)
	[-f] (change frequency, compute required)
	[-s] (change status, no computate)
	[-c] (change cat, no compute)
	[-p] (change priority, no usage yet)
	[-done] (set as complete)

1. Search JSON
2. Overwrite JSON
3. Update array
4. Report to user

DELETE

> delete/del <ID>

1. Search JSON
2. Remove JSON
3. Update array
4. Report to user

SPECIAL COMMANDS

finish <ID>  # same as update <ID> -done
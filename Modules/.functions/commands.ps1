function cmds {
    echo @"
Command      Action
-------      -------
origin       Return to workspace, home of mother script
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

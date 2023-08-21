enum TaskCategory {
    APP
    FIN
    BILL
    ACA
    HOME
    CAR
    SPEC
    NONE
}

$Task = [PSCustomObject]@{
    id = 0                           # optional
    title = "title"                  # mandatory
    deadline = $null		     # optional, behaviour: put in "unscheduled tasks"
    frequency = @(0,'D')             # optional
    status = $null                   # optional
    category = [TaskCategory]::NONE  # optional
    highPriority = $false            # optional
    isCompleted = $false             # optional
}
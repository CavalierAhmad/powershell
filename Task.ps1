# Class desc


class Task {
    [string] $id
    [string] $title
    [DateTime] $deadline
    [array] $frequency # frequency = [number, {'D','M','Y'}] where D stands for 'day', M for month, and Y for 'year'
    [string] $status = "Not started"
    [TaskCategory] $category
    [bool] $highPriority = $false
    [bool] $isCompleted = $false

    # Constructors
    Task([string]$title, [DateTime]$deadline, [array]$frequency, [TaskCategory]$category) {$this.init($title, $deadline, $frequency, $category)}
    Task([string]$title, [DateTime]$deadline, [array]$frequency)                          {$this.init($title, $deadline, $frequency)}
    Task([string]$title, [DateTime]$deadline)                                             {$this.init($title, $deadline)}
    Task([string]$title)                                                                  {$this.init($title)}
    
    # These methods link the constructors to their appropriate logic. This is necessary since constructor chaining is not allowed in Powershell
    hidden init([string]$title)                                         {$this.init($title, (get-date).AddDays(1))} # $deadline is not nullable
    hidden init([string]$title, [DateTime]$deadline)                    {$this.init($title, $deadline, $null)}
    hidden init([string]$title, [DateTime]$deadline, [array]$frequency) {$this.init($title, $deadline, $frequency, [TaskCategory]::NONE)}
    hidden init([string]$title, [DateTime]$deadline, [array]$frequency, [TaskCategory]$category) {
        $this.id = (newTaskID)
        $this.title = $title
        $this.deadline = $deadline
        $this.frequency = $frequency
        $this.category = $category
    }
    
    


    [void] ShowInfo() {
        Write-Host "ID: $($this.Id)"
        Write-Host "Title: $($this.Title)"
        # Output other properties as needed
    }
}
enum TaskCategory {
    NONE
    APP
    FIN
    HOME
    BILL
    ACA
    CAR
    SPEC
}

# External function to generate a task ID
function newTaskID {
    # Implement your ID generation logic here
    return [Guid]::NewGuid().ToString()
}

# Create an instance of the class with optional parameters
[Task]::new("title string")
[Task]::new("title string", (Get-Date))
[Task]::new("title string", (Get-Date), @(7,'D'))
[Task]::new("title string", (Get-Date), @(7,'D'), [TaskCategory]::HOME)
# $task.ShowInfo()
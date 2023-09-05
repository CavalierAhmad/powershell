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

    # SETTERS

    [void] setTitle($a){$this.title = $a}
    [void] setDeadline($a){$this.deadline = $a}
    [void] setFrequency($a){$this.frequency = $a}
    [void] setStatus($a){$this.status = $a}
    [void] setCategory($a){$this.category = $a}
    [void] setHighPriority(){$this.highPriority = -not $this.highPriority}
    [void] setComplete(){$this.isCompleted = -not $this.isCompleted}

    # GETTERS

    [string]       getTitle(){return $this.title}
    [DateTime]     getDeadline(){return $this.deadline}
    [array]        getFrequency(){return $this.frequency}
    [string]       getStatus(){return $this.status}
    [TaskCategory] getCategory(){return $this.category}
    [bool]         getPriority(){return $this.highPriority}
    [bool]         getIsCompeleted(){return $this.isCompleted}

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

# Create an instance of the class with optional parameters
#[Task]::new("title string")
#[Task]::new("title string", (Get-Date))
#[Task]::new("title string", (Get-Date), @(7,'D'))
#[Task]::new("title string", (Get-Date), @(7,'D'), [TaskCategory]::HOME)
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
        $this.id = $this.newTaskID()
        $this.title = $title
        $this.deadline = $deadline
        $this.frequency = $frequency
        $this.category = $category
    }

    # Generate a task ID, 'O' omitted cause too similar to '0'
    [string] newTaskID() {
        $characters = "ABCDEFGHIJKLMNPQRSTUVWXYZ0123456789"

        $random = Get-Random -Minimum 0 -Maximum $characters.Length
        $firstByte = $characters[$random]
        $random = Get-Random -Minimum 0 -Maximum $characters.Length
        $secondByte = $characters[$random]
    
        return "$firstByte$secondByte"
    }

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
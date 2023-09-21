function wait ($sleeptime){
    if (-not $sleeptime){$sleeptime = 60} # Default sleeptime is 60 milliseconds
    start-sleep -Milliseconds $sleeptime
}
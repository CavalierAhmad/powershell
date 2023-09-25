"PROFILE -`> welcome.ps1" >> $logfile

cls

# Display banner
slowbanner # Display banner
log 'slowbanner'

# Display datetime
$date = get-date -format "dddd, MMMM d, yyyy"
$time = get-date -format "hh:mm tt"
write-host "`nTODAY IS:" (fgo (u $date)) (f (fgg $time)) "`n";wait
log 'datetime'

$Host.UI.RawUI.ForegroundColor = $DOMAIN.consoleSettings.foregroundColor

"welcome.ps1 -`> PROFILE" >> $logfile
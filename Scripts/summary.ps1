# HERE WE CREATE TWO THINGS:
# 1. TODAY'S TIMELINE:
#    DISPLAY EVENTS AND ANY OTHER ACTIONS REQUIRING TO BE AT SPECIFIC LOCATION AND TIME
# 2. TODAY'S TASKS:
#    COMBINE ASSIGNMENTS, BILL REMINDERS FROM EXPENSES, CHORES, AND TASKS

"PROFILE -`> summary.ps1" >> $logfile

load-expenses

"summary.ps1 -`> PROFILE" >> $logfile
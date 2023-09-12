$version = "1.0" # MyTerminal version
$date = get-date -format "dddd, MMMM d, yyyy"
$time = get-date -format "hh:mm tt"
$workspace = split-path $profile -parent
$variables = "$workspace\ressources\variables.ps1" # path to variables
$aliases = "$workspace\ressources\aliases.ps1" # path to aliases
$functions = "$workspace\ressources\functions.ps1" # path to functions
$tasks = "$workspace\ressources\tasklist.ps1" # path to tasklist
$sleeptime = 60 # Set output speed for dramatic effect
$professional = "C:\Users\Ahmad\OneDrive - Algonquin College\NEXUS\PROFESSIONAL"
$myWebsite = "C:\Users\ahmad\OneDrive - Algonquin College\NEXUS\PROFESSIONAL\!PORTFOLIO\projects\website-portfolio"
$newApplication = "C:\Users\ahmad\OneDrive - Algonquin College\NEXUS\PROFESSIONAL\!PORTFOLIO\WORKSHOP\new-application"
$finalsResult = "C:\Users\Ahmad\OneDrive - Algonquin College\NEXUS\ACADEMIC\LEVEL 3\finalsResult.txt"
$downloads = "C:\Users\Ahmad\Downloads"
$trainTicket = "C:\Users\Ahmad\Downloads\Booking confirmation - VIA Rail Canada.pdf"
$market = "https://www.facebook.com/marketplace/you/selling"
$pass = "C:\Users\Ahmad\Documents\PowerShell\passwords.txt"
$bills = "C:\Users\Ahmad\OneDrive - Algonquin College\NEXUS\HOME\BILLS"
$math = "C:\Users\Ahmad\OneDrive - Algonquin College\NEXUS\z~MISC\math_practice_book.pdf"
$mathlearningtable = @"
Ali:  PW17
Toqa: PW2
Mimo: PW2
To print: actual-page = PW + 6
"@

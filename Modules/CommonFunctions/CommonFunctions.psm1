function wait ($sleeptime){
    if (-not $sleeptime){$sleeptime = 60} # Default sleeptime is 60 milliseconds
    start-sleep -Milliseconds $sleeptime
}

function slowbanner {
    echo "    ______     ________                              __";wait
    echo "   /     /__ _/__  ___/__ ___ ______ __ __  __ ___  / /";wait
    echo "  / / / // // / / // _  // _//     // //  \/ // _ \/ / ";wait
    echo " / / / // // / / // ___// / / / / // // /\  // // / /__";wait
    echo "/_/ /_/_\_  / /_//____//_/ /_/ /_//_//_/ /_/ \__\_\___/";wait
    echo "      /____/                                     v. $version";wait
}
    
function fastbanner {
@"
        ______     ________                              __
       /     /__ _/__  ___/__ ___ ______ __ __  __ ___  / /
      / / / // // / / // _  // _//     // //  \/ // _ \/ / 
     / / / // // / / // ___// / / / / // // /\  // // / /__
    /_/ /_/_\_  / /_//____//_/ /_/ /_//_//_/ /_/ \__\_\___/
          /____/                                     v. $version
"@
}

# Customize the prompt
function prompt {
    $grey = [char]27 + '[90m'  # ANSI escape code for grey text color
    $reset = [char]27 + '[0m'  # ANSI escape code to reset text color

    if ($PWD.Path -eq $origin) {
        ">"
    } elseif ($PWD.Path -like "*\NEXUS\*") {
        $nexusPart = $PWD.Path -replace ".*\\NEXUS\\?", "NEXUS\"
        "${grey}$nexusPart> ${reset}"
    } elseif ($PWD.Path -like "*\NEXUS") {
        "${grey}\NEXUS> ${reset}"
# 🌱 <-- this emoji does not work on every machine
    } else {
        "${grey}$PWD`n> ${reset}"
    }
}

function sync ($message) {
    write-host "git add" -ForegroundColor Green
    git add .
    write-host "commit" -ForegroundColor Green
    git commit -am "$message"
    write-host "git push" -ForegroundColor Green
    git push
    write-host "Status:" -ForegroundColor Green
    git status
}

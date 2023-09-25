# Customize the prompt
function prompt {
    $grey = [char]27 + '[90m'  # ANSI escape code for grey text color
    $0 = [char]27 + '[0m'  # ANSI escape code to reset text color

    if ($PWD.Path -eq $origin) {
        ">"
    } elseif ($PWD.Path -like "*\NEXUS\*") {
        $nexusPart = $PWD.Path -replace ".*\\NEXUS\\?", "NEXUS\"
        "${grey}$nexusPart${0}>"
    } elseif ($PWD.Path -like "*\NEXUS") {
        "${grey}\NEXUS${0}>"
    } else {
        "${grey}$PWD`n${0}>"
    }
}
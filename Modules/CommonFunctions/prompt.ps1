# Customize the prompt
function prompt {
    $grey = [char]27 + '[90m'  # ANSI escape code for grey text color
    $reset = [char]27 + '[0m'  # ANSI escape code to reset text color

    if ($PWD.Path -eq $workspace) {
        "${grey}> ${reset}"
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

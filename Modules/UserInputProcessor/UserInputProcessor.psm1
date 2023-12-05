function show ($string, $foreground, $background) {
    if (-not ($foreground -or $background)){write-host $string -nonewline}
elseif (-not $background){write-host $string -ForegroundColor $foreground -nonewline}
elseif (-not $foreground){write-host $string -BackgroundColor $background -nonewline}
else   {write-host $string -ForegroundColor $foreground -BackgroundColor $background -nonewline}
}

function ask ($prompt, $foregroundColor, $backgroundColor) {
    show $prompt $foregroundColor $backgroundColor
    return $Host.UI.ReadLine()
}
function ask ($prompt, $foregroundColor, $backgroundColor) {
    show $prompt $foregroundColor $backgroundColor
    return $Host.UI.ReadLine()
}
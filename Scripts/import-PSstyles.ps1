# $0      = $PSStyle.Reset  # remove all decorations

# # EFFECTS
# $b      = $PSStyle.Bold
# $i      = $PSStyle.Italic
# $u      = $PSStyle.Underline
# $blink  = $PSStyle.Blink
# $invert = $PSStyle.Reverse
# $strike = $PSStyle.Strikethrough

# # ANTI-EFFECTS (removes)
# $b0      = "`e[22m"
# $i0      = "`e[23m"
# $u0      = "`e[24m"
# $blink0  = "`e[25m"
# $invert0 = "`e[27m"
# $strike0 = "`e[29m"

# # FOREGROUND COLOURS
# $w  = $PSStyle.Foreground.White
# $w2 = $PSStyle.Foreground.BrightWhite
# $r  = $PSStyle.Foreground.Red
# $r2 = $PSStyle.Foreground.BrightRed
# $m  = $PSStyle.Foreground.Magenta
# $m2 = $PSStyle.Foreground.BrightMagenta
# $b  = $PSStyle.Foreground.Blue
# $b2 = $PSStyle.Foreground.BrightBlue
# $c  = $PSStyle.Foreground.Cyan
# $c2 = $PSStyle.Foreground.BrightCyan
# $g  = $PSStyle.Foreground.Green
# $g2 = $PSStyle.Foreground.BrightGreen
# $y  = $PSStyle.Foreground.Yellow
# $y2 = $PSStyle.Foreground.BrightYellow
# $gray = "`e[90m"    # ANSI escape code for gray text color
# $o = "`e[38;2;246;139;8m"  # My default; Custom dark yellow text color (#F68B08)

# # BACKGROUND COLOURS
# $bw  = $PSStyle.Background.White
# $bw2 = $PSStyle.Background.BrightWhite
# $br  = $PSStyle.Background.Red
# $br2 = $PSStyle.Background.BrightRed
# $bm  = $PSStyle.Background.Magenta
# $bm2 = $PSStyle.Background.BrightMagenta
# $bb  = $PSStyle.Background.Blue
# $bb2 = $PSStyle.Background.BrightBlue
# $bc  = $PSStyle.Background.Cyan
# $bc2 = $PSStyle.Background.BrightCyan
# $bg  = $PSStyle.Background.Green
# $bg2 = $PSStyle.Background.BrightGreen
# $by  = $PSStyle.Background.Yellow
# $by2 = $PSStyle.Background.BrightYellow

# # TEST
# Write-Host "Bold:${b}Bold"
# Write-Host "Italic:${i}Italic"
# Write-Host "Underline:${u}Underline"
# Write-Host "Strike:${strike}Strike"
# Write-Host "Blink:${blink}Blink"
# Write-Host "Invert:${invert}Invert${0}"
# Write-Host "${r}This text is red"
# Write-Host "${g}This text is green"
# Write-Host "${y}This text is yellow"
# Write-Host "${b}This text is blue"
# Write-Host "${m}This text is magenta"
# Write-Host "${c}This text is cyan"
# Write-Host "${w}This text is white"
# Write-Host "${gray}This text is gray"
# Write-Host "${o}This text is darkorange"
# Write-Host "${br}"
# Write-Host "${bg}"
# Write-Host "${by}"
# Write-Host "${bb}"
# Write-Host "${bm}"
# Write-Host "${bc}"
# Write-Host "${bw}"
# Write-Host "${0}"
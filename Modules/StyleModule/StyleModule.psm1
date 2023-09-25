$0       = $PSStyle.Reset  # remove all decorations
$default = "`e[33m"        # default color, dark yellow

# EFFECTS
$b      = $PSStyle.Bold
$i      = $PSStyle.Italic
$u      = $PSStyle.Underline
$blink  = $PSStyle.Blink
$invert = $PSStyle.Reverse
$strike = $PSStyle.Strikethrough

# ANTI-EFFECTS (removes)
$b0      = "`e[22m"
$i0      = "`e[23m"
$u0      = "`e[24m"
$blink0  = "`e[25m"
$invert0 = "`e[27m"
$strike0 = "`e[29m"

function b ($string) {return "${b}$string${b0}"}
function i ($string) {return "${i}$string${i0}"}
function u ($string) {return "${u}$string${u0}"}
function f ($string) {return "${blink}$string${blink0}"}   # f for flash
function n ($string) {return "${invert}$string${invert0}"} # n for negative
function s ($string) {return "${strike}$string${strike0}"} # s for strikethrough
function blink ($string) {Write-Host "`e[5m$string`e[25m"}

function gray ($string) {return "`e[90m" + $string + $default}
function fgw ($string) {return "`e[97m" + $string + $default}
function fgr ($string) {return "`e[31m" + $string + $default}
function fgm ($string) {return "`e[38;2;255;0;255m" + $string + $default}
function fgb ($string) {return "`e[94m" + $string + $default}
function fgc ($string) {return "`e[96m" + $string + $default}
function fgg ($string) {return "`e[92m" + $string + $default}
function fgy ($string) {return "`e[38;2;255;255;0m" + $string + $default}
function fgo ($string) {return "`e[38;2;246;139;8m" + $string + $default}
function bgray ($string) {return "`e[100m" + $string + "`e[49m"}
function bgw ($string) {return "`e[107m" + $string + "`e[49m"}
function bgr ($string) {return "`e[41m" + $string + "`e[49m"}
function bgm ($string) {return "`e[48;2;255;0;255m" + $string + "`e[49m"}
function bgb ($string) {return "`e[44m" + $string + "`e[49m"}
function bgc ($string) {return "`e[106m" + $string + "`e[49m"}
function bgg ($string) {return "`e[42m" + $string + "`e[49m"}
function bgy ($string) {return "`e[48;2;255;255;0m" + $string + "`e[49m"}
function bgo ($string) {return "`e[101m" + $string + "`e[49m"}

# TESTING
Write-Host (b Bold)
Write-Host (i Italic)
Write-Host (u Underline)
Write-Host (s Strike)
Write-Host (f Blink)
Write-Host (n Invert)
Write-Host (fgw "white")
Write-Host (fgr "red")
Write-Host (fgo "orange")
write-host (fgm "magenta")
Write-Host (fgb "blue")
Write-Host (fgc "cyan")
Write-Host (fgg "green")
Write-Host (fgy "yellow")
Write-Host (bgray "gray                                                                                    ")
Write-Host (bgw "white                                                                                   ")
Write-Host (bgr "red                                                                                     ")
Write-Host (bgo "orange                                                                                  ")
Write-Host (bgm "magenta                                                                                 ")
Write-Host (bgb "blue                                                                                    ")
Write-Host (bgc "cyan                                                                                    ")
Write-Host (bgg "green                                                                                   ")
Write-Host (bgy (fgr "yellow                                                                                  "))

# OLD TESTS
# Write-Host "${y}This text is yellow"
# Write-Host "${b}This text is blue"
# Write-Host "${m}This text is magenta"
# Write-Host "${c}This text is cyan"
# Write-Host "${w}This text is white"
# Write-Host "${gray}This text is gray"
# Write-Host "${o}This text is darkorange"
# Write-Host "${br}Red"
# Write-Host "${bg}Green"
# Write-Host "${by}Yellow"
# Write-Host "${bb}Blue"
# Write-Host "${bm}Magenta"
# Write-Host "${bc}Cyan"
# Write-Host "${bw}White"
# Write-Host "${0}"
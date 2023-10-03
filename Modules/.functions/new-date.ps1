function new-date ($dateString) {
    try {
        $date = [DateTime]::ParseExact($dateString, "yyyy-MM-dd", [System.Globalization.CultureInfo]::InvariantCulture)
        return $date
    }
    catch {
        Write-Host (n (fgr "Error!")) (fgr "Required format:") (fgm "yyyy-mm-dd")
        return (fgr "error @ new-date")
    }
}
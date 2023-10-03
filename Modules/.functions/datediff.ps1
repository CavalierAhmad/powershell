function datediff ($startDate,$endDate,$timeUnit) {
    $dateDiff = New-TimeSpan -start $startDate -end $endDate

    if (-not $timeUnit){$timeUnit = "days"}
    return $dateDiff.$timeUnit
}
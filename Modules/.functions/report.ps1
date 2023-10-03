# maps request to proper report
function report ($request){
    switch ($request) {
        "expenses" {ExpenseManager\new-report}
        "hyundai" {FleetDatabase\new-report}
        Default {write-host (fgr "Invalid request.")}
    }
}
# Routing function

function new-report ($request) {
    switch ($request) {
        "expenses" {ExpenseManager\new-report}
        "income" {echo "income"}
        "hyundai" {FleetDatabase\new-report}
        Default {echo "Options:`n1. expenses`n2. income`n3. hyundai"}
    }
}
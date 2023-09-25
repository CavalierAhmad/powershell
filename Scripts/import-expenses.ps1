$bills = fromjson $DOMAIN.json.expenses
$bills += [ordered]@{dummy=0}

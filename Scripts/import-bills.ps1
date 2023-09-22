$bills = fromjson $DOMAIN.paths.json.bills
$bills += [ordered]@{dummy=0}

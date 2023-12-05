$chores = fromjson $DOMAIN.json.chores
$chores += [ordered]@{dummy=0}
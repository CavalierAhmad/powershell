$chores = fromjson $DOMAIN.paths.json.chores
$chores += [ordered]@{dummy=0}
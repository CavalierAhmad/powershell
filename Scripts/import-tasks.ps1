$tasks = fromjson $DOMAIN.json.tasks
$tasks += [ordered]@{dummy=0}
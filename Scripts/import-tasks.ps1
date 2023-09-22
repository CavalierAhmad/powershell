$tasks = fromjson $DOMAIN.paths.json.tasks
$tasks += [ordered]@{dummy=0}
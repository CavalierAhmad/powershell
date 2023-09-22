$events = fromjson $DOMAIN.paths.json.events
$events += [ordered]@{dummy=0}
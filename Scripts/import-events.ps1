$events = fromjson $DOMAIN.json.events
$events += [ordered]@{dummy=0}
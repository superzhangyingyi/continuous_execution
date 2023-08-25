APIKEY="a360f1fc1e7cc76bc2d9c3156a40b599"
JOBUUID="47c07aec3d8611ee800000505692225b"
curl -H "X-API-Key:$APIKEY" -H "Content-Type: application/json" -X POST -d '[{"job_uuid": "'$JOBUUID'", "action":"start"}]' "http://192.168.3.118/d2/r/v2/job/action"

TOKEN="86eca62af2938be0b4568f8982ea947b"
COOKIE="dbackup3.session=5b0413e737b0e2a4878de1fc2f6c68f0f74792fdc67fa9113b681f5990806b74"
JOBUUID="47c07aec3d8611ee800000505692225b"
curl --cookie "$COOKIE" -H "X-CSRF-Token:$TOKEN" -H "Content-Type: application/json" -X POST -d '[{"job_uuid": "'$JOBUUID'", "action":"start"}]' "http://192.168.3.118/d2/r/v2/job/action"

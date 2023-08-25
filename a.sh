COOKIE="dbackup3.session=05b02f04ffe9ea5e55c052aa6e2edf9efb72cb51204b5a63a8ebd69d32ca8759"
TOKEN="ea36e2ab37a8d95773924313829da1e1"
JOBUUID="52f1065c3b1a11ee800000505692225b"
string=$(curl --cookie "$COOKIE" -H "Content-Type:application/json" -H "X-CSRF-Token:$TOKEN" "http://192.168.3.118/d2/r/v2/jobs?uuid=$JOBUUID")
tp1=${string#*state}
tp2=${tp1:3}
aStatus=$(echo ${tp2} | awk -F '"' '{print $1}')
case $aStatus in
	"completed")
		echo "canrun b"
		;;
	"running" | "starting")
		echo "running or starting"
		while true; do
			string=$(curl --cookie "$COOKIE" -H "Content-Type:application/json" -H "X-CSRF-Token:$TOKEN" "http://192.168.3.118/d2/r/v2/jobs?uuid=$JOBUUID")
			tp1=${string#*state}
			tp2=${tp1:3}
			aStatus2=$(echo ${tp2} | awk -F '"' '{print $1}')
			if [ $aStatus2 == "running" ] || [ $aStatus2 == "starting" ]; then
				echo "wait"
			else
				break
			fi
			sleep 1
		done
		if [ $aStatus2 == "completed" ] || [ $aStatus2 == "idle" ]; then
			echo "can run b now"
		else
			echo "${aStatus2} cannot run"
			exit 1
		fi
		;;
	*)
		echo "${aStatus} cannot run"
		exit 1
		;;
esac

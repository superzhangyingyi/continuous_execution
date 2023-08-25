APIKEY="a360f1fc1e7cc76bc2d9c3156a40b599"
JOBUUID="52f1065c3b1a11ee800000505692225b"
string=$(curl -H "Content-Type:application/json" -H "X-API-Key:$APIKEY" "http://192.168.3.118/d2/r/v2/jobs?uuid=$JOBUUID")
tp1=${string#*state}
tp2=${tp1:3}
aStatus=$(echo ${tp2} | awk -F '"' '{print $1}')
echo "$aStatus"
case $aStatus in
	"completed")
		echo "canrun b"
		exit 0
		;;
	"running" | "starting")
		echo "running or starting"
		while true; do
			string=$(curl -H "Content-Type:application/json" -H "X-API-Key:$APIKEY" "http://192.168.3.118/d2/r/v2/jobs?uuid=$JOBUUID")
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
			exit 0
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

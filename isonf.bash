#!/bin/bash
case $1 in
    start)
	echo "Using ports $2 $3" 
	/home/apanda/bess/core/nvport/native_apps/iso_test -i "$2" \
	     -o "$3" -c "$4" -p 60 > /var/log/$5.log &
	echo $! > /var/run/$5.pid
	;;
    stop)
	pid=$(cat /var/run/$2.pid)
	echo "Going to kill $pid"
	kill $pid
	sleep 0.25
	while kill -0 $pid; do	
		kill -9 $pid
		sleep 1
	done &> /dev/null
	;;
esac
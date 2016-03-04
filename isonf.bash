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


sudo qemu-system-x86_64 -nographic -serial mon:stdio -append 'console=ttyS0' -enable-kvm -cpu host -m 1024M -smp 2,threads=1,sockets=1 -chardev socket,id=char0,path=/tmp/sn_vhost_p1 -netdev type=vhost-user,id=mynet0,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet0,mac=52:54:00:02:d9:00 -object memory-backend-file,id=mem,size=1024M,mem-path=/mnt/huge,share=on -numa node,memdev=mem -mem-prealloc -net user,hostfwd=tcp::10022-:22 -net nic /home/vHost/vyos-test4.qcow2 

sudo qemu-system-x86_64 -enable-kvm -cpu host -m 1024M -smp 2,threads=1,sockets=1 -chardev socket,id=char0,path=/tmp/sn_vhost_p1 -netdev type=vhost-user,id=mynet0,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet0,mac=52:54:00:02:d9:00 -object memory-backend-file,id=mem,size=1024M,mem-path=/mnt/huge,share=on -numa node,memdev=mem -mem-prealloc -net user,hostfwd=tcp::10022-:22 -net nic /home/vHost/vyos-test4.qcow2

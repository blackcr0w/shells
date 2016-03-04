#!/bin/bash

# FIXME: Copy out to local disks rather than running off of NFS
VM_BASE_IMAGE="/opt/e2/dp/vyos/vyos-test4.qcow2"	# this is a folder mounted to every server?
VM_INSTANCE="vyos_fw_$2_$3"

case $1 in
    ### TODO: USE LIBVIRT INTEAD OF QEMU/BASH
    start)
	echo "starting $VM_INSTANCE"
	# REMOVE ANY FILES HANGING AROUND FROM A RUN OF AN IDENTICALLY NAMED PREVIOUS INSTANCE
	rm /var/run/$VM_INSTANCE.pid /var/log/$VM_INSTANCE.log $VM_INSTANCE.qcow2 &> /dev/null
	# CREATE A FRESH IMAGE FOR THIS INSTANCE
	qemu-img create -f qcow2 -o backing_file=$VM_BASE_IMAGE $VM_INSTANCE.qcow2 2G &> /var/log/$VM_INSTANCE.log
	# LAUNCH THE VM
	virt-install --connect qemu:///system --ram 512 \
	-n $VM_INSTANCE -r 1024 --os-type=linux --os-variant=generic \
	--disk path=$VM_INSTANCE.qcow2,device=disk,bus=virtio,format=qcow2 \
	--vcpus=2 --console pty,target_type=serial --noautoconsole --import \
	--graphics none

	# qemu-system-x86_64 -enable-kvm -cpu host -m 1024M -smp 2,threads=1,sockets=1 -chardev socket,id=char0,path=/tmp/sn_vhost_$2 -netdev type=vhost-user,id=mynet0,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet0,mac=52:54:00:02:d9:00 -chardev socket,id=char1,path=/tmp/sn_vhost_$3 -netdev type=vhost-user,id=mynet1,chardev=char1,vhostforce -device virtio-net-pci,netdev=mynet1,mac=52:54:00:02:d9:01 -object memory-backend-file,id=mem,size=1024M,mem-path=/mnt/huge,share=on -numa node,memdev=mem -mem-prealloc -nographic $VM_INSTANCE.img &> /var/log/$VM_INSTANCE.log &
	echo $! > /var/run/$VM_INSTANCE.pid
	;;
    stop)
	echo "stopping $VM_INSTANCE"
	# KILL THE VM
	# ps auwx | grep qemu | grep $VM_INSTANCE  | awk '{print $2}' | sudo xargs kill -9
	virsh shutdown $VM_INSTANCE
	# REMOVE ASSOCIATED TMP FILES
	sudo rm /tmp/sn_vhost_$2 &> /dev/null
	sudo rm /tmp/sn_vhost_$3 &> /dev/null
	;;
esac
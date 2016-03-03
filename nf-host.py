#!/usr/bin/python2.7

import os
import subprocess
import sys

def ccall (cmd):
  try:
  	cmd = cmd.split()
  	subprocess.check_call(cmd)
  except:
    print "Executing", args
    raise
def main():
	nf = str(sys.argv[0])
	config = str(sys.argv[1])
	print "Args are: {} and {}".format(nf, config)

	boot_cmd = 'sudo qemu-img create -o base.img vyos.img '
	guest_id = 'vyos-test'
	if nf == 'fw': 
		guest_id = 'vyos-test4'
	elif nf == 'nat':
		guest_id = 'vyos'
	elif nf == 'vpn':
		guest_id = 'vyos-test'
	config_cmd = 'ssh vyos@' + guest_id + ' python ' + config

	ccall(boot_cmd)
	ccall('sleep 10')
	ccall(config_cmd)
$ sudo qemu-system-x86_64 -enable-kvm -cpu host -m 1024M -smp 2,threads=1,sockets=1 
-chardev socket,id=char0,path=/tmp/sn_vhost_vh0 -netdev type=vhost-user,i
d=mynet0,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet0,
mac=52:54:00:02:d9:00 -chardev socket,id=char1,path=/tmp/sn_vhost_vh1 -netdev type=vhost-user,
id=mynet1,chardev=char1,vhostforce -device virtio-net-pci,netdev=mynet1,mac=52:54:00:02:d9:01 
-object memory-backend-file,id=mem,size=1024M,mem-path=/mnt/huge,share=on -numa node,memdev=mem 
-mem-prealloc -net user,hostfwd=tcp::10022-:22 -net nic /path/to/image


localhost:10514 $ add port VPort vp1 container_pid=174445,
name='test_container_eth0',ifname='eth0',ip_addr='192.168.10.1/24',mac_addr='02:00:00:00:00:02'

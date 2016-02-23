#!/bin/bash

apt-get install aptitude

aptitude install qemu-kvm libvirt-bin

adduser <user id> kvm

adduser <user id> libvirt

virsh --connect qemu:///system list --all

mkdir /home/vHost

qemu-img create -f qcow2 /home/vHost/vyos.qcow2 4G

wget http://mirror.tuxhelp.org/vyos/iso/release/1.1.7/vyos-1.1.7-amd64.iso

# may need this:  virsh net-autostart default

virt-install \
--name vyos \
--ram 1024 \
--disk path=/home/vHost/vyos.qcow2,size=4 \
--vcpus 1 \
--os-type linux \
--os-variant generic \
--graphics none \
--console pty,target_type=serial \
--cdrom ./vyos-1.1.7-amd64.iso \
--accelerate

# Then, the VyOS installation console will pop out automatically,
# <user:password> = <vyos:vyos>
# vyos@vyos:~$ install image 
# vyos@vyos:~$ reboot

# To reboo the guest, in host:
# virsh reboot <domain-name>

# To login text console:
# virsh console <domain-name>

# I'll do the SSH thing later


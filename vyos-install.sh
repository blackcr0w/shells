#!/bin/bash
sudo apt-get update

apt-get install aptitude

aptitude install qemu-kvm libvirt-bin qemu-img

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

# install deb file:
# wget https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4_x86_64.deb

# dpkg -i vagrant_1.7.4_x86_64.deb

# apt-get install -f

# apt-get remove <packet>


sudo apt-get install vagrant
sudo apt-get -y install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev
vagrant plugin install vagrant-libvirt
vagrant plugin install vagrant-mutate
vagrant plugin install vagrant-vyos

vagrant up --provider=libvirt

IP:
vyos-test: 192.168.122.223/24
vyos-test2: 192.168.122.100
vyos-test3: 192.168.0.1

qemu-img create -f qcow2 /home/vHost/vyos-snapshot-test.qcow2 2G

virt-install \
--name vyos \
--ram 512 \
--disk path=/home/vHost/vyos-snapshot.qcow2,size=2,device=disk,bus=virtio,format=qcow2 \
--vcpus 1 \
--os-type linux \
--os-variant generic \
--graphics none \
--console pty,target_type=serial \
--accelerate
--import

virt-install --connect qemu:///system --ram 512 \
-n vyos-snapshot -r 2048 --os-type=linux --os-variant=generic \
--disk path=/home/vHost/vyos-snapshot.qcow2,device=disk,bus=virtio,format=qcow2 \
--vcpus=2 --console pty,target_type=serial --noautoconsole --import \
--graphics none \

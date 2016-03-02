#!/bin/bash
sudo ip link add eth1 type veth peer name eth2
# sudo ip link set dev eth1 up
# sudo ip link set dev eth2 up
sudo ifconfig eth1 up
sudo ifconfig eth2 up
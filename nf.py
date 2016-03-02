#!/usr/bin/python2.7

import argparse
import os
import subprocess

def ccall (cmd):
  try:
  	cmd = cmd.split()
  	subprocess.check_call(cmd)
  except:
    print "Executing", args
    raise

parser = argparse.ArgumentParser()
parser.add_argument("--fw", help="Boot n firewall with default config.")
parser.add_argument("--nat", help="Boot n NAT with default config.")
parser.add_argument("--vpn", help="Boot n VPN with default config.")
args = parser.parse_args()

if args.fw:
	for _ in range(arg.fw):
		ccall("sudo virsh start vyos-test4")
	ccall("sudo virsh list --all")
	ccall("sudo /bin/bash /home/jack/shells/nf-test.sh")
if args.nat:
	for _ in range(arg.nat):
		ccall("sudo virsh start vyos")
	ccall("sudo virsh list --all")
	ccall("sudo /bin/bash /home/jack/shells/nf-test.sh")

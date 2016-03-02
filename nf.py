#!/usr/bin/python2.7

import argparse
import os
import subprocess

def ccall (*args):	# args is a list passing in
  try:
    #print ">", args
    subprocess.check_call(*args)
  except:
    print "Executing", args
    raise

parser = argparse.ArgumentParser()
parser.add_argument("--fw", help="Boot n firewall with default config.")
parser.add_argument("--nat", help="Boot n NAT with default config.")
parser.add_argument("--vpn", help="Boot n VPN with default config.")
args = parser.parse_args()
if args.fw:
	ccall("sudo virsh start vyos-test4")
	ccall("sudo bash /home/jack/shell/nf-test.sh")


# parser.add_argument("--verbosity", help="increase output verbosity")
# if args.verbosity:
#     print "verbosity turned on"
# parser.add_argument("square", help="display a square of a given number",
#                     type=int)
# parser.add_argument("--verbosity", help="increase output verbosity")
# args = parser.parse_args()
# if args.verbosity:
#     print "verbosity turned on"
# if args.square:
# 	print args.square**2
# 	print args.verbosity
# the added arg is an attr of object: args. that's why we can print args.square

# parser = argparse.ArgumentParser(description='Short sample app')

# parser.add_argument('-a', action="store_true", default=False)
# parser.add_argument('-b', action="store", dest="b")
# parser.add_argument('-c', action="store", dest="c", type=int)

# print parser.parse_args(['-a', '-bval', '-c', '3'])
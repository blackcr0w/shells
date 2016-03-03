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

parser = argparse.ArgumentParser(description='NF boot up in Server Agent')
parser.add_argument('-s', '--server_id', help='Give a server ID, e.g., c8.',
                    type=str, action='store', required=True, default='c8')
parser.add_argument('-n', '--nf', help='Give a type of NF, e.g., fw, nat, vpn',
                    type=str, action="store", required=True, default='vpn')
parser.add_argument('-c', '--config', help='Configures of NF. For long configs, quote in \' \' .',
                    type=str, action="store", required=False, default=None)

args = parser.parse_args()
# print args.server_id
# print args.nf
# print args.config

server_id = args.server_id
nf = args.nf
config = args.config

server_cmd = 'ssh root@' + server_id + '.millennium.berkeley.edu ' + host_cmd
host_cmd = 'sudo python nf-host.py ' + nf + ' ' + config

if __name__ == '__main__':
	ccall(host_cmd)


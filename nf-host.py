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

	boot_cmd = 'sudo virsh start '
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
	

	
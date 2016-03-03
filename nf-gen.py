#!/usr/bin/python2.7
import os
import sys
import argparse

""" Generate NF configs in a .vbash file in current folder. """
parser = argparse.ArgumentParser(description='Generate NF configs in a .vbash file in current folder.')
parser.add_argument('-n', '--nf', help='Give a type of NF, e.g., fw, nat, vpn',
                    type=str, action="store", required=True, default='fw')
parser.add_argument('-c', '--count', help='Number of nf policies. \' \' .',
                    type=int, action="store", required=False, default=None)
args = parser.parse_args()
if args.count >= 9999:
	print 'Too many polocies for an NF.'
	sys.exit()

def main():
	base = 25000
	with open("configs.vbash", "a+") as f:
		f.write( "#!/bin/vbash \nsource /opt/vyatta/etc/functions/script-template\nconfigure\n\n")

		f.write('set firewall name OUTSIDE-IN default-action \'drop\'\n')
		f.write('set firewall name OUTSIDE-IN rule 1 action \'accept\'\n')
		f.write('set firewall name OUTSIDE-IN rule 1 state established \'enable\'\n')
		f.write('set firewall name OUTSIDE-IN rule 1 state related \'enable\'\n\n')

		f.write('set firewall name OUTSIDE-LOCAL default-action \'drop\'\n')
		if args.nf == 'fw':
			for _ in range(args.count):
				rule = _ + 1
				port = _ + base
				f.write('set firewall name OUTSIDE-LOCAL rule ' + str(rule) + ' action \'drop\' \n')
				f.write('set firewall name OUTSIDE-LOCAL rule ' + str(rule) + ' destination port \'' + str(port) + '\' \n')
				f.write('set firewall name OUTSIDE-LOCAL rule ' + str(rule) + ' protocol \'tcp\'\n')
		print 'Generated ' + str(args.count) + 'firewall policies: dropping packets of port number: 25000 - ' + str(base)
	# f.closed
	

if __name__ == '__main__':
	main()
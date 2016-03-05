#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

configure

set interfaces ethernet eth0 address dhcp
set interfaces ethernet eth0 description 'OUTSIDE'
# set interfaces ethernet eth1 address '192.168.0.1/24'
# set interfaces ethernet eth1 description 'INSIDE'

commit 


set service ssh port '22'

# set service dhcp-server disabled 'false'
# set service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 default-router '192.168.0.1'
# set service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 dns-server '192.168.0.1'
# set service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 domain-name 'internal-network'
# set service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 lease '86400'
# set service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 start 192.168.0.9 stop '192.168.0.254'

commit

set service dns forwarding cache-size '0'
set service dns forwarding listen-on 'eth1'
set service dns forwarding name-server '8.8.8.8'
set service dns forwarding name-server '8.8.4.4'

commit

set nat source rule 100 outbound-interface 'eth0'
set nat source rule 100 source address '192.168.0.0/24'
set nat source rule 100 translation address masquerade

commit 

# interfaces ethernet eth1 duplex auto
# commit

save

exit

# run show configuration
set firewall name OUTSIDE-LOCAL rule 112 action 'accept'
set firewall name OUTSIDE-LOCAL rule 112 destination port '200'
set firewall name OUTSIDE-LOCAL rule 112 protocol 'tcp'
set firewall name OUTSIDE-LOCAL rule 112 state new 'enable'

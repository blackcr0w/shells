#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

configure

# set interfaces ethernet eth0 address dhcp
# set interfaces ethernet eth0 description 'OUTSIDE'

# set interfaces ethernet eth1 address '192.168.0.1/24'
# set interfaces ethernet eth1 description 'INSIDE'


commit 

save

set interfaces ethernet eth0 address dhcp
set interfaces ethernet eth0 description 'OUTSIDE'

# set interfaces ethernet eth1 address '192.168.0.1/24'
# set interfaces ethernet eth1 description 'INSIDE'

# set interfaces ethernet eth2 address dhcp

commit 

save

set service ssh port '22'

set nat source rule 100 outbound-interface 'eth0'
set nat source rule 100 source address '192.168.0.0/24'
set nat source rule 100 translation address masquerade

commit 

save

set service dhcp-server disabled 'false'
set service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 default-router '192.168.0.1'
set service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 dns-server '192.168.0.1'
set service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 domain-name 'internal-network'
set service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 lease '86400'
set service dhcp-server shared-network-name LAN subnet 192.168.0.0/24 start 192.168.0.9 stop '192.168.0.254'

set service dns forwarding cache-size '0'
set service dns forwarding listen-on 'eth1'
set service dns forwarding name-server '8.8.8.8'
set service dns forwarding name-server '8.8.4.4'

commit 

# set interfaces ethernet eth1 duplex 'auto'
# set interfaces ethernet eth1 speed 'auto'
# set interfaces ethernet eth2 duplex 'auto'
# set interfaces ethernet eth2 speed 'auto'

save

exit

run show interfaces




# del protocols static route 0.0.0.0/0 next-hop 8.8.4.4 distance '1'
# del protocols static route 0.0.0.0/0 next-hop 172.16.0.0 distance '1'
# del protocols static route 0.0.0.0/0 next-hop 172.16.0.1 distance '1'
# del protocols static route 8.8.8.8/32 next-hop 172.16.1.1 distance '1'
# del protocols static route 10.0.0.0/8 blackhole distance '254'
# del protocols static route 172.16.0.0/12 blackhole distance '254'
# del protocols static route 172.16.0.0/12 next-hop 172.16.0.2 distance '1'
# del protocols static route 172.16.0.0/24 next-hop 172.16.0.2 distance '1'
# del protocols static route 172.16.1.0/24 next-hop 172.16.1.2 distance '1'
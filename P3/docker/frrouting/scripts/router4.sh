#!/bin/bash

echo "Warning : Use Bash not sh !!!"

ip link add name vxlan10 type vxlan id 10 dev eth2 dstport 4789
ip link set dev vxlan10 up
ip link add name br0 type bridge
ip link set dev br0 up
brctl addif br0 eth0
brctl addif br0 vxlan10

vtysh
<< EOF

	no ipv6 forwarding

	interface eth2
		ip address 10.1.1.10/30
		ip ospf area 0
	exit

	interface lo
		ip address 1.1.1.4/32
		ip ospf area 0
	exit

	router bgp 1
		neighbor 1.1.1.1 remote-as 1
		neighbor 1.1.1.1 update-source lo

		 address-family l2vpn evpn
			neighbor 1.1.1.1 activate
			advertise-all-vni
		exit-address-family
	exit
	router ospf
	exit
EOF
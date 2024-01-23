#!/bin/bash

echo "Warning : Use Bash not sh !!!"
# configure terminal for frr routing
vtysh
	<< EOF

	no ipv6 forwarding

	interface eth0
		ip address 10.1.1.1/30
	exit

	interface eth1
		ip address 10.1.1.5/30
	exit

	interface eth2
		ip address 10.1.1.9/30
	exit

	interface lo
		ip address 1.1.1.1/32
	exit

	# Enable a routing process BGP with AS number 1
	router bgp 1

		# Create a BGP peer-group tagged ibgp
		neighbor ibgp peer-group
		# Assign the peer group to AS number 1
		neighbor ibgp remote-as 1

		# Communicate with a neighbor through lo interface
		neighbor ibgp update-source lo

		# Configure BGP dynamic neighbors listen on specified TRUSTED range and add then to specified peer group
		bgp listen range 1.1.1.0/29 peer-group ibgp

		# Configure a neighbor in peer group ibgp as Route Reflector client
		address-family l2vpn evpn
			neighbor ibgp activate
			neighbor ibgp route-reflector-client
		exit-address-family
	exit

	# Enable routing process OSPF on all IP networks on area 0
	# OSPF = Open Shortest Path First
	router ospf
		network 0.0.0.0/0 area 0
	exit
EOF
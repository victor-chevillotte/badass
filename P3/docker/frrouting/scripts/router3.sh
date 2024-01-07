#!/bin/bash

echo "Warning : Use Bash not sh !!!"

# vxlan config
brctl addbr br0
ip link set up dev br0
ip link add vxlan10 type vxlan id 10 dstport 4789
ip link set up dev vxlan10
brctl addif br0 vxlan10
brctl addif br0 eth0

vtysh
conf t

no ipv6 forwarding

interface eth1
ip address 10.1.1.6/30
ip ospf area 0

interface lo
ip address 1.1.1.3/32

ip ospf area 0

router bgp 1
neighbor 1.1.1.1 remote-as 1
neighbor 1.1.1.1 update-source lo

address-family l2vpn evpn
neighbor 1.1.1.1 activate
advertise-all-vni
exit-address-family

router ospf

end
write memory
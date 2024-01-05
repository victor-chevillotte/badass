#!/bin/bash

echo "Warning : Use Bash not sh !!!"

# Prompt for unicast or multicast
read -p "Activate Unicast (u) or Multicast (m)? " choice

# vxlan config
ip link add br0 type bridge
ip link set dev br0 up
ip addr add 10.1.1.2/24 dev eth0

case $choice in
  u|U)
    echo "Setting up Unicast..."

	# VXLAN unicast 
	ip link add name vxlan10 type vxlan id 10 dev eth0 remote 10.1.1.2 local 10.1.1.1 dstport 4789
	;;
  m|M)
	echo "Setting up Multicast..."
	# VXLAN multicast
	ip link add name vxlan10 type vxlan id 10 dev eth0 group 239.1.1.1 dstport 4789
 	;;
	*)
    echo "Invalid choice. Please run the script again and choose either 'u' for Unicast or 'm' for Multicast."
    exit 1
    ;;
esac

ip addr add 20.1.1.2/24 dev vxlan10

ip link set dev vxlan10 up

brctl addif br0 eth1 
brctl addif br0 vxlan10
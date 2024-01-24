# P3

## Goal

We want host 1, host 2 and host 3 to communicate together as if they were on the same network (On the same LAN) even if they are not.  
This time we want to setup a network in which every router knows all the mac adresses of the devices connected to it. This can be done by using `BGP EVPN`.  
In addition we will keep our VXLAN configuration as explained in P2 to enable the hosts to communicate with each other.

## How EVPN is used to share mac addresses connected to the network ?

Please go to the root Readme to have the definition of spine/leaf routers.

In an EVPN (Ethernet VPN) environment, particularly in a spine-leaf architecture, the discovery and sharing of MAC addresses work through a coordinated effort between the leaf and spine routers. Here's how it generally works:

1. **MAC Address Discovery at Leaf Routers**:
    - When a new device connects to the network, it is typically connected to a leaf router (or switch).
    - The leaf router learns the MAC address of the new device through traditional Layer 2 learning methods. When a device sends a frame, the source MAC address of that frame is learned and stored in the MAC address table of the leaf router.

2. **Propagation of MAC Address Information**:
    - Once the leaf router learns a new MAC address, it uses EVPN to propagate this information to other routers in the network, including spine routers.
    - EVPN employs BGP (Border Gateway Protocol) as its control plane to distribute MAC address reachability information. This means that when a leaf router learns a new MAC address, it advertises this information to its BGP peers, which include the spine routers in the network.

3. **Learning MAC Addresses at Spine Routers**:
    - Spine routers receive these advertisements and update their own BGP tables with the MAC address information, along with associated metadata like the VNI (VXLAN Network Identifier) and the IP address of the advertising leaf router.
    - While spine routers learn about the existence and reachability of these MAC addresses, they typically do not directly forward client traffic. Their primary role is to facilitate the proper routing of traffic between leaf routers.

4. **Synchronization Among Leaf Routers**:
    - Other leaf routers in the network also receive these BGP advertisements. This allows all leaf routers to have synchronized knowledge about the MAC addresses in the network, even if they did not directly learn them from connected devices.
    - This synchronization ensures that any leaf router can forward traffic to any MAC address in the network, as it knows which leaf router is connected to that particular MAC address.


The routing schema is as follows

![](resources/badass_p3.drawio.png)

## Configurations

Name               		| Interface | IP Address | Mask
------------------------|-----------|------------|-------------------
host_mdesoeuv-1    		| eth1      | 20.1.1.1   | 24 (255.255.255.0)
host_mdesoeuv-2    		| eth0      | 20.1.1.2   | 24
host_mdesoeuv-3    		| eth0      | 20.1.1.3   | 24
routeur_mdesoeuv-1 (RR) | eth0      | 10.1.1.1   | 30 (255.255.255.252)
routeur_mdesoeuv-1 (RR) | eth1      | 10.1.1.5   | 30
routeur_mdesoeuv-1 (RR)	| eth2	   	| 20.1.1.9   | 30
routeur_mdesoeuv-1 (RR)	| lo		| 1.1.1.1    | 32 (255.255.255.255)
routeur_mdesoeuv-2 		| eth0      | 10.1.1.2   | 30
routeur_mdesoeuv-2 		| lo	    | 1.1.1.2    | 32     
routeur_mdesoeuv-3 		| eth0      | 10.1.1.3   | 30
routeur_mdesoeuv-3 		| lo	    | 1.1.1.3    | 32     
routeur_mdesoeuv-4 		| eth0      | 10.1.1.4   | 30
routeur_mdesoeuv-4 		| lo	    | 1.1.1.4    | 32     


### Router RR (Spine)

Spine Router must be configurated first, all commands are included in a script named `router1_RR.sh` in the root directory  
The router must be setup with the command `bash router1_RR.sh`  

Le script que vous avez fourni est un script Bash pour configurer un routeur utilisant FRR (Free Range Routing), un logiciel de routage réseau. Voici les explications des différentes étapes du script :
Sure, I'll explain the provided Bash script in English. This script is for configuring a router using FRR (Free Range Routing), a network routing software. Here's the breakdown of the script's steps:

1. **Entering vtysh Mode for FRR Routing Configuration**:
   ```bash
   vtysh << EOF
	conf t
   ```
   This command enters the vtysh mode, a command-line interface for FRR, enabling the configuration of the router. `conf t` stands for configuration which enables us to use the cli below :

2. **Configuration of Interfaces and IP Addresses**:
   - Disabling IPv6 routing:
     ```
     no ipv6 forwarding
     ```
   - Setting up IP addresses for the interfaces `eth0`, `eth1`, `eth2`, and the loopback interface `lo`:
     ```
     interface [interface name]
         ip address [IP address]/[subnet mask]
     exit
     ```

3. **BGP (Border Gateway Protocol) Configuration**:
   - Enabling the BGP routing process with Autonomous System (AS) number 1:
     ```bash
     router bgp 1
     ```
   - Setting up a BGP peer group and associating it with AS number 1:
     ```bash
     neighbor ibgp peer-group
     neighbor ibgp remote-as 1
     ```
   - Setting the update source for BGP and dynamic listening for BGP neighbors:
     ```bash
     neighbor ibgp update-source lo
     bgp listen range 1.1.1.0/29 peer-group ibgp
     ```
   - Configuring route reflector clients in the `l2vpn evpn` address family:
     ```bash
     address-family l2vpn evpn
         neighbor ibgp activate
         neighbor ibgp route-reflector-client
     exit-address-family
     ```

4. **OSPF (Open Shortest Path First) Configuration**:
   - Enabling the OSPF routing process on all IP networks in area 0:
     ```bash
     router ospf
         network 0.0.0.0/0 area 0
     exit
     ```

### Routers (Leafs)

Leafs Router must then be configurated, all commands are included in a script named `router1.sh`, `router2.sh` and `router3.sh` in the root directory  
Each router must be setup with the command `bash router<router_number>.sh`  


Certainly! Here's an explanation of the provided Bash script in English. This script is for configuring a router using FRR (Free Range Routing) with a focus on OSPF and BGP configurations.


1. **Entering vtysh Mode for FRR Routing Configuration**:
   ```bash
   vtysh << EOF
   ```
   This initiates the vtysh mode, a command-line interface for FRR, to begin configuring the router.

2. **Configuration of Interfaces and IP Addresses**:
   - Entering configuration mode:
     ```bash
     conf t
     ```
   - Disabling IPv6 routing:
     ```bash
     no ipv6 forwarding
     ```
   - Setting up the IP address for the `eth0` interface and enabling OSPF for this interface:
     ```bash
     interface eth0
         ip address 10.1.1.2/30
         ip ospf area 0
     exit
     ```
   - Configuring the loopback interface `lo` with an IP address and enabling OSPF:
     ```bash
     interface lo
         ip address 1.1.1.2/32
         ip ospf area 0
     exit
     ```

3. **BGP (Border Gateway Protocol) Configuration**:
   - Enabling the BGP routing process with Autonomous System (AS) number 1:
     ```bash
     router bgp 1
     ```
   - Configuring a BGP neighbor in the same AS and setting the update source:
     ```bash
     neighbor 1.1.1.1 remote-as 1
     neighbor 1.1.1.1 update-source lo
     ```
   - Enabling the L2VPN EVPN address family for the BGP neighbor and advertising all local VNIs (Virtual Network Identifiers):
     ```bash
     address-family l2vpn evpn
         neighbor 1.1.1.1 activate
         advertise-all-vni
     exit-address-family
     ```

4. **OSPF (Open Shortest Path First) Configuration**:
   - Enabling the OSPF routing process:
     ```bash
     router ospf
     exit
     ```
In summary, this script configures the `eth0` and loopback interfaces with IP addresses and OSPF settings, sets up BGP with a specific neighbor, and enables L2VPN EVPN address family for neighbor communication and VNI advertisement. It focuses on integrating OSPF and BGP for effective routing management.

### Hosts

Finally, for each host, the IP address of eth1 must be set  
A script is provided in the root directory and is executed with the command `sh host<host_number>.sh`  


1. Setup eth1 IP : 
```
$ ip addr add <ip_address>/<mask> dev eth1
```


### Checks

#### On the Host console

`ping <host_ip>`


#### On the Router console

```bash 
	vtysh
```

```bash 
	conf t
```

To check bgp config :

```bash 
	router bgp 1
```
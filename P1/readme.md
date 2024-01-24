## P1

The focus of this first part is the configuration of the software GNS3 and the host + router containers that will be deployed in the GNS3 Project    

The whole project runs in a Ubuntu 22.04 VM  


### GNS3

- GNS3 is a free and open source software used to run Network topologies locally  
For this project we will take advantage of the docker compatibility of GNS3 to run host and routers as containers  

- Wireshark is included and allows to monitor the traffic going through each link of our topology  


### Router container

- The router container is based on the open source internet routing protocol suite FRRouting  
All protocols requested by the subject are supported and a lightweight docker image is actively maintained   

- We provide Dockerfile that wraps the base image of FRRouting with `iproute2` and `bridge-utils` to have full-fledged `ip` and `brctl` commands available in `/sbin/ip` and `/usr/sbin/brctl` : The `-d` flag (detailed) is not available in the busybox native `ip` binary and the `showmacs` argument is not available in the busybox native `brctl` binary  
The daemons configuration is mounted in the container with requested protocols enabled (bgp, ospf, is-is) and the vytsh console enabled and configured in the `vtysh-conf` file    

- Configuration scripts for each routers are included in the wrapped image for simplicity  
After being added to the GNS3 project and started, router containers are configured by lauching the configuration script with a number corresponding to the router id number      

- The build script provided in each part of the project will build and tag the docker image with the part number : `frrouting:p1`   


### Host container

- This container is based on a Alpine image
- Host configuration scripts are provided in the built image, tagged with the part number : `host:p1`


## GLOSSARY

### FRROUTING
- **FRRouting (FRR):** An open-source Internet routing protocol suite for Linux and Unix platforms. It includes several protocol-specific daemons and a central daemon called zebra. These daemons manage protocols and build routing tables based on exchanged information.

### ZEBRA
- **zebra:** A daemon that integrates routes from multiple protocols and updates the Linux kernel's routing table. Described as an IP routing manager in FRRouting, zebra is responsible for managing kernel routing table updates, interface lookups, and route redistribution. It is enabled by default, with the option to activate other daemons as needed.

### BGPD
- **bgpd:** This daemon implements the Border Gateway Protocol (BGP) to manage network routing tables. Its role is to share network reachability information with other BGP systems, using a multi-step decision process to determine the best routing paths.

### OSPFD
- **ospfd:** A daemon for the Open Shortest Path First (OSPF) protocol, aimed at replacing the older RIP protocol. OSPF offers faster response to network changes, improved failure detection, and a comprehensive understanding of the network topology among routers.

### ISISD
- **ISIS:** A routing protocol offering scalable network support and quick convergence, similar to OSPF. The isisd daemon requires interface information from zebra and must be started after zebra. It is configured through a specific file, isisd.conf.

### BUSYBOX
- **BusyBox:** A compilation of many common UNIX utilities into a single, small executable. It serves as a substitute for utilities found in GNU fileutils, shellutils, etc., and is designed for small or embedded systems with a focus on size efficiency.

### Daemon Status Configuration
- **Enabled Daemons:** bgpd, ospfd, isisd
- **Disabled Daemons:** ospf6d, ripd, ripngd, pimd, ldpd, nhrpd, eigrpd, babeld, sharpd, pbrd, bfdd, fabricd, vrrpd, pathd

### Daemon Options
- General options for each daemon are set to connect to the address "127.0.0.1" or "::1" for IPv6-specific daemons. This includes settings for zebra, bgpd, ospfd, and others, indicating their network interface configurations.

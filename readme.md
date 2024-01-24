# Bgp At Doors of Autonomous Systems is Simple (BADASS)

The purpose of this project is to deepen our knowledge of networking by simulating several networks (VXLAN+BGP-EVPN) in GNS3.

## GLOSSARY

### FRROUTING
- **FRRouting (FRR):** An open-source Internet routing protocol suite for Linux and Unix platforms. It includes several protocol-specific daemons and a central daemon called zebra. These daemons manage protocols and build routing tables based on exchanged information.

### ZEBRA
- **zebra:** A daemon that integrates routes from multiple protocols and updates the Linux kernel's routing table. Described as an IP routing manager in FRRouting, zebra is responsible for managing kernel routing table updates, interface lookups, and route redistribution. It is enabled by default, with the option to activate other daemons as needed.

### BGPD (Border Gateway Protocol Deamon)
- **bgpd:** This daemon implements the Border Gateway Protocol (BGP) to manage network routing tables. Its role is to share network reachability information with other BGP systems, using a multi-step decision process to determine the best routing paths.

### OSPFD (Open Shortest Path First Deamon)
- **ospfd:** A daemon for the Open Shortest Path First (OSPF) protocol, aimed at replacing the older RIP protocol. OSPF offers faster response to network changes, improved failure detection, and a comprehensive understanding of the network topology among routers.

### IS-IS (Intermediate System to Intermediate System)
- **IS-IS:** A routing protocol designed for use within an administrative domain or network. It is a link-state protocol, similar to OSPF, and efficiently routes data in complex networks of routers and switches. IS-IS is used for routing IP and, historically, CLNS traffic.

### BUSYBOX
- **BusyBox:** A compilation of many common UNIX utilities into a single, small executable. It serves as a substitute for utilities found in GNU fileutils, shellutils, etc., and is designed for small or embedded systems with a focus on size efficiency.

### Daemon Status Configuration
- **Enabled Daemons:** bgpd, ospfd, isisd
- **Disabled Daemons:** ospf6d, ripd, ripngd, pimd, ldpd, nhrpd, eigrpd, babeld, sharpd, pbrd, bfdd, fabricd, vrrpd, pathd

### Daemon Options
- General options for each daemon are set to connect to the address "127.0.0.1" or "::1" for IPv6-specific daemons. This includes settings for zebra, bgpd, ospfd, and others, indicating their network interface configurations.

### VTEP (Virtual Tunnel End Point)
- **VTEP:** A component in VXLAN architecture that maps end devices to VXLAN segments and performs VXLAN encapsulation and de-encapsulation. VTEPs are responsible for encapsulating the original Ethernet frame into a VXLAN packet, adding a VXLAN header, and then sending it through the underlying IP network.


### MPLS (Multiprotocol Label Switching)
- **MPLS:** A routing technique in telecommunications networks that directs data from one node to the next based on short path labels rather than long network addresses. MPLS can encapsulate packets of various network protocols and is highly scalable and protocol agnostic.

### Route Reflector
- **Route Reflector:** A network node in a BGP network used to reduce the number of iBGP connections in the network. Route reflectors allow iBGP routers to share routes without the requirement of a full mesh configuration, simplifying network design and reducing overhead.

### Spine & Leaf Router
- **Spine & Leaf Router:** In network architecture, this refers to a two-layer hierarchical topology. The 'leaf' layer consists of access switches that connect devices like servers, while the 'spine' layer is composed of switches that leaf switches connect to. This topology optimizes east-west network traffic, commonly seen in data centers.

### VNI (VXLAN Network Identifier)
- **VNI:** A unique identifier used in VXLAN environments to designate individual VXLAN segments and enable layer 2 adjacency across a shared layer 3 network. The VNI in the VXLAN header distinguishes different tenant networks or segments within a shared infrastructure.

### EVPN (Ethernet VPN)
- **EVPN:** A VPN technology that leverages BGP to provide Ethernet connectivity between sites. EVPN supports multi-tenancy, scalable host MAC learning, and efficient multi-homing. It's commonly used in data center interconnect and service provider applications.

### ICMP (Internet Control Message Protocol)
- **ICMP:** A network layer protocol used by network devices to diagnose network communication issues. ICMP is mainly used for error reporting and operational inquiries, like determining if data is reaching its intended destination in a timely manner.
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

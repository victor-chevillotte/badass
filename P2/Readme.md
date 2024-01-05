# P2

## Configurations

Name               | Interface | IP Address | Mask
-------------------|-----------|------------|-------------------
host_mdesoeuv-1    | eth1      | 30.1.1.1   | 24 (255.255.255.0)
host_mdesoeuv-2    | eth1      | 30.1.1.2   | 24
routeur_mdesoeuv-1 | eth0      | 10.1.1.1   | 24
routeur_mdesoeuv-2 | eth0      | 10.1.1.2   | 24

### Hosts
For each host, follow these steps:

1. Rename eth0 as eth1 :
By default interface is named eth0. We set it as eth1 to follow the 42 subject.
```
$ ip link set eth0 down # stop the interface
```
```
$ ip link set eth0 name eth1 # change name
```
```
$ ip link set eth1 up # restart interface
```

2. Setup eth1 IP : 
```
$ ip addr add <ip_address>/<mask> dev eth1
```

### Routers

1. Set up eth0 IP :
   
```
$ ip addr add <ip_address>/<mask> dev eth0
```

3. Establish a bridge between eth0 and VXLAN :
```
$ ip link add name br0 type bridge
$ ip link set eth1 master br0
$ ip link set br0 up
```

3. Configure VXLAN:

- Create VXLAN unicast:
```
$ ip link add name vxlan10 type vxlan id 10 dev eth0 remote <ip_address_other_router> dstport 4789
```
OR 

- Create VXLAN multicast:
```
ip link add name vxlan10 type vxlan id 10 dev eth0 group 239.1.1.1 dstport 4789
``````

- Add VXLAN to bridge
```
$ ip link set vxlan10 master br0
$ ip link set vxlan10 up
```

error

```
BusyBox v1.30.1 (Ubuntu 1:1.30.1-7ubuntu3) multi-call binary.

Usage: ip [OPTIONS] address|route|link|tunnel|neigh|rule [ARGS]

OPTIONS := -f[amily] inet|inet6|link | -o[neline]

ip addr add|del IFADDR dev IFACE | show|flush [dev IFACE] [to PREFIX]
ip route list|flush|add|del|change|append|replace|test ROUTE
ip link set IFACE [up|down] [arp on|off] [multicast on|off]
	[promisc on|off] [mtu NUM] [name NAME] [qlen NUM] [address MAC]
	[master IFACE | nomaster]
ip tunnel add|change|del|show [NAME]
	[mode ipip|gre|sit] [remote ADDR] [local ADDR] [ttl TTL]
ip neigh show|flush [to PREFIX] [dev DEV] [nud STATE]
ip rule [list] | add|del SELECTOR ACTION
```

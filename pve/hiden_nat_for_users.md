if you want to use nat, but your users need change network interface, you can setup iptables into debian (proxmox ve installing on debian-based distro)

create .sh file for iptables rules

*** Index of ipt.sh

```
## delete older iptables rules
iptables -t filter -F
iptables -t nat -F

iptables -t filter -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

##accept connect DNS to your local DNS server
iptables -t filter -A FORWARD -m conntrack --ctstate NEW -i vmbr0 -o enp0s31f6 -p udp --dport 53 -d {ROUTER_IP_ADDR} -j ACCEPT

##drop connect to your local network
iptables -t filter -A FORWARD -i vmbr0 -o enp0s31f6 -d {LOCAL_NETWORK_IP_WITH_NETMASK} -j DROP

#accept ping from vm to ISP
iptables -t filter -A FORWARD -m conntrack --ctstate NEW -i vmbr0 -o enp0s31f6 -p icmp --icmp-type 8 -j ACCEPT

#accept 80,443 for vms
iptables -t filter -A FORWARD -m conntrack --ctstate NEW -i vmbr0 -o enp0s31f6 -p tcp -m multiport --dports 80,443 -j ACCEPT

#drop unaccepted connections
iptables -t filter -A FORWARD -j DROP

#masquerading vm connection
iptables -t nat -A POSTROUTING -o enp0s31f6 -j MASQUERADE 
```

*** set up basic isc-dhcp

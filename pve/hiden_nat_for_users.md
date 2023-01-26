if you want to use nat, but your users need change network interface, you can setup iptables into debian (proxmox ve installing on debian-based distro). warn notice: i'm not sure, that will stable works, do it on your fear and risk.

create .sh file for iptables rules

### Index of ipt.sh

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
then, install iptables-persistent for save your iptables rules
``` apt install iptables-persistent ```

### Setup basic isc-dhcp

```apt install isc-dhcp-server```

### Index of /etc/dhcp/dhcpd.conf

```
...

subnet 172.16.111.0 netmask 255.255.255.0 {
  range 172.16.111.10 172.16.111.210;
  option routers 172.16.111.1;
  option domain-name-servers {LOCAL_DHCP_SERVER};
}

...
```

### Index of /etc/defauts/isc-dchp-server

```
...

INTERFACESv4="vmbr0"

...
```
now, check ```ps -aux | grep dhcp```. proxmox ve may be spawn own dhcp server (i'm not sure)
if you have pre-started dhcp serve, you can't start custom isc-dhcp-server.service. well, i don't know either best idea then stop this service and delete dhcp.pid file.

```
ps -aux | grep dhcp
pkill -9 dhcpd
ps -aux | grep dhcp
rm /var/run/dhcpd.pid
systemctl start isc-dhcp-server
```

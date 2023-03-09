BR=br0
ETH=eth5
IP=10.0.95.5/16
GW=10.0.5.1
DNS=10.0.5.1
ip link add dev $BR type bridge
ip link set dev $BR up
ip address del $IP dev $ETH
ip address add $IP dev $BR
ip link set dev $ETH master $BR
ip link set dev $ETH up
ip route del default dev $ETH
ip route add default via $GW dev $BR
echo $DNS > /etc/resolv.conf
modprobe tun
modprobe tap

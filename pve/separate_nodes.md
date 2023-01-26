if you want separate nodes from cluster mode to local mode and delete from Proxmox VE GUI older nodes you need:

stop pve services:

* systemctl stop pve-cluster
* systemctl stop corosync
switch proxmox file system to local mode:
* pmxcfs -l
delete info about another host:
* rm /etc/pve/nodes/{node_name}
* rm /etc/pve/corosync.conf
* rm -r /etc/corosync/
start service in normal mode;
* killall pmxcfs
* systemctl start pve-cluster

more info: https://pve.proxmox.com/wiki/Cluster_Manager

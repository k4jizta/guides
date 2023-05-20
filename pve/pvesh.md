create pool by shell command
`pvesh create /pools --poolid [poolid] --comment mycomment`

create more then 1 poll by script 
```bash
#!/bin/bash
# Basic while loop
counter=1
while [ $counter -le 15 ]
do
pvesh create /pools --poolid pool$counter --comment 'create via sh script'
echo $counter
((counter++))
done
```
if u wanna to create empty OVS bridge interface in PVE, just copy to `/etc/network/interfaces`

```bash
...
auto vmbrXX
iface vmbrXX inet manual
        ovs_type OVSBridge
#COMMENT SECTION
...
```
after that, you need restart network settings by `systemctl restart networking`

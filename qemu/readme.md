first of all, install qemu, libvirt, lvm, ssh

then rewrite `sh` files (bridge.sh, vm-hv.sh)

start lvm service
`rc-service lvm start
rc-update add lvm boot`
mount lvm
`mount /dev/data/lvm-local /mnt/disk1/ -t ext4`

start bridge.sg and vm-hv.sh


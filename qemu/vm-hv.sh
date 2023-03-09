NAME=hv
PID=vm-$name.pid

DISK=/mnt/disk1/hv.img
ISO=/root/ru_microsoft_hyper-v_server_2019_x64_dvd_2ea02425.iso
RAM=131072M
CPU=16
VRAM=8
ID=0
NUM=$(expr $ID + 10)
IF=tap$NUM
MAC=00:0B:35:00:00:$NUM
PORT=$NUM
BR=br0

ip tuntap add dev $IF mode tap
ip link set $IF up
ip link set $IF master $BR


qemu-system-x86_64      \
        -name $NAME     \
        -daemonize      \
        -nodefaults     \
        -accel kvm      \
        -vnc :$PORT        \
        -device VGA,vgamem_mb=$VRAM     \
        -m $RAM \
        -cpu host       \
        -smp $CPU,sockets=1,cores=$CPU,threads=1        \
        -drive id=drive,format=qcow2,if=none,file=$DISK \
        -device ich9-ahci,id=ahci0      \
        -device ide-hd,bus=ahci0.0,drive=drive  \
        -netdev tap,id=net,ifname=$IF,script=no,downscript=no   \
        -device e1000,netdev=net,mac=$MAC       \
        -device usb-ehci,id=ehci0       \
        -device usb-tablet,bus=ehci0.0  \
        -cdrom $ISO \

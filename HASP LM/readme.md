# HASP
## Important notice:

I use ESXi 6.7 like virtualization server (128 GB of RAM and 20 CPU cores) and debian 11. For VM i use 1 GB of ram, 30 GB of SSD and 1 CPU core. My solution can be different with your **hardware** and **software** solutions. 

## How to install:
1. intall debian (or another linux distro) on VM or PC via ISO
2. install ssh (for remote control) and setup [PubKeyAuthentication](https://github.com/k4jizta/guides/blob/main/debian_11_sshd_publickey)
3. `wget https://sd7.ascon.ru/Public/Utils/Sentinel%20HASP/Linux_driver/aksusbd-8.21.1.tar` *(check version)*
4. `tar -tvf aksusbd-8.21.1 && cd aksusbd-8.21.1` better, when you `chmod +x` this folder, but not secure.
5. `run ./dinst` 
6. check `systemctl status hasplmd` and `ss -tuan | greep 1947` if it running
7. sym links created. service started. now we need open `localhost:1947`, but when you try open `https://x.x.x.x:1947` you have 403 forbidden error page.
8. so, you can create ssh tunnel: `ssh -L 127.0.0.1:23456:x.x.x.x:1947 root@x.x.x.x`
`127.0.0.1` -- your pc ip, `23456` -- free TCP port on yout pc, `x.x.x.x` -- HASP LM server IP, `1947` -- HASP LM web interface port and then `root@x.x.x.x`, which means you connecting to this host and tunneling port from this host to your PC custom port.
10. go to **"Sentinel Keys"** and check your **Phisical keys**. Make sure, that phisical keys are connected (you can blink them)
11. then on client *(i use Ascon Kompas 3D)* you need configure connect to HASP LM server. Go to **"Configuration"** --> **"Access to Remote License Manager"**. Turn off **"Broadcast Search for Remote Lisenses"** and write ip address HASP LM server in **text field**. Wait and check on **"Products"**

install vsftpd
``
apt instal vsftpd
``
create folder forr FTP, chown and chmod them
```
mkdir /ftp 
mkdir -p /ftp/USERNAME1/{RO,RW}
chown -R username1:ftp-users /ftp/USERNAME1
chmod 750 /ftp/USERNAME1/RO
chmod 770 /ftp/USERNAME1/RW
chattr +u /ftp/USERNAME1/RW
```
another one
```
mkdir /ftp/USERNAME
chown -R root:ftp-users /ftp/USERNAME2
chmod 700 /ftp/USERNAME2
```
change config file
nano /etc/vsftpd
```
listen=YES
listen_ipv6=NO
anonymous_enable=YES
local_enable=YES
write_enable=YES
local_umask=027
connect_from_port_20=YES

#logs of uploaded files 
xferlog_enable=YES

#disable user see tree's root
chroot_local_user=YES

#only allowed in  vsftp.userlist file users
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
```

create links into second user

```
mkdir /ftp/USERNAME2/USERNAME1
mount --bind /ftp/USERNAME1 /ftp/USERNAME2/USERNAME1
```

## You need to have the build-essentials package installed to do this.
```
sudo apt-get install build-essential
```
## install zlib
```
wget http://www.zlib.net/zlib-1.2.13.tar.gz
cd zlib-1.2.13/
./configure --prefix=/usr/local
make
make install
```
## install httpd-2.2.32
```
wget https://archive.apache.org/dist/httpd/httpd-2.2.32.tar.gz
tar -zxvf httpd-2.2.32.tar.gz
cd httpd-2.2.32/
ls -la
./configure --prefix=/usr/local/apache2 --enable-mods-shared=all --enable-deflate --enable-proxy --enable-proxy-balancer --enable-proxy-http
make
make install
```
## run apache-httpd-server 
`sudo /usr/local/apache2/bin/apachectl start`

## check is server works
`ss -npl | grep 80`

![изображение](https://user-images.githubusercontent.com/101405719/236360335-62a962c5-2d11-4bec-bee9-5ebaa6ddd612.png)

`curl -v http://localhost`

![изображение](https://user-images.githubusercontent.com/101405719/236360275-9fb846a5-75e1-460d-a7e3-3de0f7806019.png)

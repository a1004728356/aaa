#!/bin/bash
yum -y install  unzip zip gcc pcre-devel openssl-devel
#nginx
cd nginx-1.12.2
./configure --prefix=/data/nginx  --with-http_ssl_module --with-stream
make && make install
ln -s /data/nginx/sbin/nginx /sbin
cd ..
#php1
yum -y install openldap-devel
yum -y install freetype-devel
yum -y install libpng-devel
yum -y install libjpeg-devel
yum -y install curl-devel
yum -y install openssl openssl-devel
yum -y install libxml2-devel
yum -y install bzip2 bzip2-devel
cd aaa
cd php-5.6.17
./configure --prefix=/data/php \
--with-config-file-path=/data/php/etc \
--with-bz2 \
--with-curl \
--enable-ftp \
--enable-sockets \
--disable-ipv6 \
--with-gd \
--with-jpeg-dir=/data \
--with-png-dir=/data \
--with-freetype-dir=/data \
--enable-gd-native-ttf \
--with-iconv-dir=/data \
--enable-mbstring \
--enable-calendar \
--with-gettext \
--with-ldap \
--with-libxml-dir=/data \
--with-zlib \
--enable-dom \
--enable-xml \
--enable-fpm \
--with-libdir=lib64 \
--enable-bcmath
make && make install
cd ../..
#memcached
wget http://ftp.gnu.org/gnu/m4/m4-1.4.9.tar.gz
tar -zvxf m4-1.4.9.tar.gz
cd m4-1.4.9/
./configure && make && make install
cd ../
yum -y install autoconf
yum -y install gcc-c++
cd 网页支持memcached
cd libmemcached-1.0.18
./configure --prefix=/data/libmemcached --enable-sasl
make && make install
cd ..
cd memcached-2.2.0
/data/php/bin/phpize
./configure --enable-memcached --with-php-config=/data/php/bin/php-config --with-libmemcached-dir=/data/libmemcached --disable-memcached-sasl
make && make install

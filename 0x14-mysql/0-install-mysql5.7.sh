#!/usr/bin/env bash
# MySql v5.7 installation

# First get the public key from the vendor
# https://dev.mysql.com/doc/refman/5.7/en/checking-gpg-signature.html

# Copy and paste it into the file signature.key
# vi signature.key

sudo apt-key add signature.key
sudo sh -c 'echo "deb http://repo.mysql.com/apt/ubuntu bionic mysql-5.7" >>
	/etc/apt/sources.list.d/mysql.list'

sudo apt-get update
sudo apt-cache policy mysql-server
sudo apt install -y -f mysql-client=5.7* mysql-community-server=5.7* \
	mysql-server=5.7*


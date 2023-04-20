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
sudo apt upgrade -y
sudo apt-cache policy mysql-server
sudo apt install -y -f mysql-client=5.7* mysql-community-server=5.7* \
	mysql-server=5.7*
sudo mysql --version

sudo apt install ufw -y
sudo ufw default incoming deny
sudo ufw default outgoing allow
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 8080
sudo ufw allow 3306
sudo ufw --force enable
sudo systemctl status ufw
sudo sustemctl enable --now mysql
#source ~/bin/mysql-config.sh
#source ~/bin/nginx-install-config.sh
#source install others:
#  git
#  pycodestyle
#  betty
#  shellcheck
#  puppet
#  puppet-lint
#  semistandard
#  vim
#  nodejs
#  fab?
#  python3
#  aliases

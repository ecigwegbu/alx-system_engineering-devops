# Puppet Manaifest to install nginx


#!/usr/bin/env bash
# install nginx on a new ubuntu server

#sudo su
exec { 'sudo su':
  command => '/usr/bin/sudo su'
}

#apt update
exec { 'apt_update':
  command => '/usr/bin/apt update'
}

# apt install -y nginx
package { 'nginx':
  ensure   => installed,
  provider => '/usr/bin/apt',
}


# Hello World file
file { '/var/www/html/index.html':
  path    => '/var/www/html/index.html',
  mode    => '0644',
  content => 'Hello World!'
}

#service nginx start
service { 'nginx':
  enable   => true;
  ensure   => running,
}
# apt install -y ufw
package { 'ufw':
  ensure   => installed,
  provider => '/usr/bin/apt',
}

# ufw incoming
exec { 'ufw_def_incoming':
  command => '/usr/bin/ufw default deny incoming'
}
# ufw outgoing
exec { 'ufw_def_outgoing':
  command => '/usr/bin/ufw default allow outgoing'
}

# ufw port 22 
exec { 'ufw_port22':
  command => '/usr/bin/ufw allow 22/tcp'
}
# ufw port 80 
exec { 'ufw_port80':
  command => '/usr/bin/ufw allow 80/tcp'
}
# ufw enable 
exec { 'ufw_enable':
  command => '/usr/bin/ufw --force enable'
}
echo "Ceci n'est pas une page." > /usr/share/nginx/html/error404.html

# add redirect line
line1="\tserver_name _;"
line2="\terror_page 404 \/error404.html;"
line3="\tlocation = \/error404.html {"
line4="\t\troot \/usr\/share\/nginx\/html;"
line5="\t\tinternal;"
line6="\t}"
# line2="\trewrite \/redirect_me https:\/\/www.youtube.com\/watch?v=QH2-TGUlwu4 permanent;"
sed -i "s/^[[:blank:]]server_name _;/$line1\n$line2\n$line3\n$line4\n$line5\n$line6/" \
	/etc/nginx/sites-enabled/default

service nginx reload
exit

# This puppet manifest creates a file in /tmp
file { '/tmp/school':
  path    => '/tmp/school',
  mode    => '0744',
  owner   => 'www-data',
  group   => 'www-data',
  content => 'I love Puppet'
}



# This puppet manifest installs flask from pip3
package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}



# This puppet manifest kills a process
exec { 'killmenow':
  command => '/usr/bin/pkill -u root killmenow'
}



#!/usr/bin/env bash
# install nginx on a new ubuntu server

sudo su
apt update
apt install -y nginx
service nginx start
apt install -y ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw --force enable
echo "Hello World!" > /var/www/html/index.html
service nginx reload
exit

# Puppet Manifest to install nginx
# install nginx on a new ubuntu server

#apt update
exec { 'apt_update':
  command => '/usr/bin/apt update',
}

# apt install -y nginx
-> package { 'nginx':
  ensure   => installed,
  provider => 'apt',
}

# apt install -y ufw
-> package { 'ufw':
  ensure   => installed,
  provider => 'apt',
}

# ufw incoming
-> exec { 'ufw_def_incoming':
  command => '/usr/sbin/ufw default deny incoming',
}
# ufw outgoing
-> exec { 'ufw_def_outgoing':
  command => '/usr/sbin/ufw default allow outgoing',
}

# ufw port 22 
-> exec { 'ufw_port22':
  command => '/usr/sbin/ufw allow 22',
}
# ufw port 80 
-> exec { 'ufw_port80':
  command => '/usr/sbin/ufw allow 80',
}
# ufw enable 
-> exec { 'ufw_enable':
  command => '/usr/sbin/ufw --force enable',
}

# Hello World file
-> file { '/var/www/html/index.html':
  path    => '/var/www/html/index.html',
  mode    => '0644',
  content => 'Hello World!',
}

# First, remove any previous redirect:
-> exec { 'sed_rem_prev_redirect':
  command => '/bin/sed -i --follow-symlinks "s/^\s*rewrite \/redirect_me.*$//g" \
    /etc/nginx/sites-enabled/default',
}

# Redirection - 301
-> exec { 'sed_redirection_301':
  command => '/bin/sed -i --follow-symlinks \
    "s/^\s*server_name _;/\tserver_name _;\n\trewrite \/redirect_me \
https:\/\/www.youtube.com\/watch?v=QH2-TGUlwu4 permanent;/" \
    /etc/nginx/sites-enabled/default',
}

# First, remove any previous custom response header:
-> exec { 'sed_rem_prev_header':
  command => '/bin/sed -i --follow-symlinks "s/^\s*add_header X-Served-By.*$//g" \
    /etc/nginx/sites-enabled/default',
}

# add custom header 
-> exec { 'sed_add_header':
  command => '/bin/sed -i --follow-symlinks \
    "s/^\s*server_name _;/\tserver_name _;\n\tadd_header X-served-By $(hostname);/" \
    /etc/nginx/sites-enabled/default',
}

#service nginx start
-> service { 'nginx':
  ensure => running,
  enable => true,
}

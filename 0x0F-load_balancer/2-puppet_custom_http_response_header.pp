# Puppet Manifest to install nginx
# install nginx on a new ubuntu server

#apt update
exec { 'apt_update':
  command => '/usr/bin/apt update',
  notify  => Package['nginx'],
}

# apt install -y nginx
package { 'nginx':
  ensure   => installed,
  provider => 'apt',
  notify   => Package['ufw'],
}

# apt install -y ufw
package { 'ufw':
  ensure   => installed,
  provider => 'apt',
  notify   => Exec['ufw_def_incoming'],
}

# ufw incoming
exec { 'ufw_def_incoming':
  command => '/usr/sbin/ufw default deny incoming',
  notify  => Exec['ufw_def_outgoing'],
}
# ufw outgoing
exec { 'ufw_def_outgoing':
  command => '/usr/sbin/ufw default allow outgoing',
  notify  => Exec['ufw_port22'],
}

# ufw port 22 
exec { 'ufw_port22':
  command => '/usr/sbin/ufw allow 22/tcp',
  notify  => Exec['ufw_port80'],
}
# ufw port 80 
exec { 'ufw_port80':
  command => '/usr/sbin/ufw allow 80/tcp',
  notify  => Exec['ufw_enable'],
}
# ufw enable 
exec { 'ufw_enable':
  command => '/usr/sbin/ufw --force enable',
  notify  => File['/var/www/html/index.html'],
}

# Hello World file
file { '/var/www/html/index.html':
  path    => '/var/www/html/index.html',
  mode    => '0644',
  content => 'Hello World!',
  notify  => Exec['sed_rem_prev_redirect'],
}

# First, remove any previous redirect:
exec { 'sed_rem_prev_redirect':
  command => '/bin/sed -i --follow-symlinks "s/^\s*rewrite \/redirect_me.*$//g" \
    /etc/nginx/sites-enabled/default',
  notify  => Exec['sed_redirection_301'],
}

# Redirection - 301
exec { 'sed_redirection_301':
  command => '/bin/sed -i --follow-symlinks \
    "s/^\s*server_name _;/\tserver_name _;\n\trewrite \/redirect_me \
https:\/\/www.youtube.com\/watch?v=QH2-TGUlwu4 permanent;/" \
    /etc/nginx/sites-enabled/default',
  notify  => Exec['sed_rem_prev_header'],
}

# First, remove any previous custom response header:
exec { 'sed_rem_prev_header':
  command => '/bin/sed -i --follow-symlinks "s/^\s*add_header X-Served-By.*$//g" \
    /etc/nginx/sites-enabled/default',
  notify  => Exec['sed_add_header'],
}

# add custom header 
exec { 'sed_add_header':
  command => '/bin/sed -i --follow-symlinks \
    "s/^\s*server_name _;/\tserver_name _;\n\tadd_header X-served-By $(hostname);/" \
    /etc/nginx/sites-enabled/default',
  notify  => Service['nginx'],
}

#service nginx start
service { 'nginx':
  ensure => running,
  enable => true,
}

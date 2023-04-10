#apt update
exec { 'apt_update':
  command => '/usr/bin/apt update',
  notify  => Package['nginx'],
}

# apt install -y nginx
package { 'nginx':
  ensure   => installed,
  provider => 'apt',
  notify   => File['/var/www/html/index2.html'],
}

# Hello World file
file { '/var/www/html/index.html2':
  path    => '/var/www/html/index2.html',
  mode    => '0644',
  content => 'Hello World!',
  notify  => Service['nginx'],
}

#service nginx start
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

# apt install -y ufw
package { 'ufw':
  ensure   => installed,
  provider => 'apt',
} ->

# ufw incoming
exec { 'ufw_def_incoming':
  command => '/usr/sbin/ufw default deny incoming',
} ->
# ufw outgoing
exec { 'ufw_def_outgoing':
  command => '/usr/sbin/ufw default allow outgoing',
} ->

# ufw port 22
exec { 'ufw_port22':
  command => '/usr/sbin/ufw allow 22/tcp',
} ->
# ufw port 80
exec { 'ufw_port80':
  command => '/usr/sbin/ufw allow 80/tcp',
} ->
# ufw enable
exec { 'ufw_enable':
  command => '/usr/sbin/ufw --force enable',
}

# First, remove any previous redirect:
exec { 'sed_rem_prev_redirect':
  command => '/usr/bin/sed -i --follow-symlinks \
    "s/^\s*rewrite \/redirect_me.*$//g" default',
}

# Redirection - 301
$rline1="\tserver_name _;
        rewrite /redirect_me"
$newurl='https://www.youtube.com/watch?v=QH2-TGUlwu4'
exec { 'sed_redirection_301':
  command => '/usr/bin/sed -i --follow-symlinks \
    "s/^[[:blank:]]server_name _;/$rline1 $newurl permanent;/" \
    default',
  require => Exec['sed_rem_prev_redirect'],
}

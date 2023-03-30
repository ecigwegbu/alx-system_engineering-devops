#ssh client configuration using puppet

$src = "#ssh client configuration using puppet
PasswordAuthentication no
IdentityFile ~/.ssh/school
"
file { '/etc/ssh/ssh_config.d/client.conf':
  path    => '/etc/ssh/ssh_config.d/client.conf',
  mode    => '0644',
  owner   => 'root',
  group   => 'root',
  content => $src,
  notify  => Service['ssh']
}

service { 'ssh':
  ensure => running,
  enable => true
}

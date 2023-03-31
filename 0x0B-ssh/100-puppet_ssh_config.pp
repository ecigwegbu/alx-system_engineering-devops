#ssh client configuration using puppet

exec { 'edit_ssh_config':
  command => "/usr/bin/echo '    IdentityFile ~/.ssh/school' >> '/etc/ssh/ssh_config';
              /usr/bin/echo '    PasswordAuthentication no' >> '/etc/ssh/ssh_config' ",
  notify  => Service['ssh']
}
service { 'ssh':
  ensure => running,
  enable => true
}

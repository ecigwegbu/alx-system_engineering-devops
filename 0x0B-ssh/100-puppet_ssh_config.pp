#ssh client configuration using puppet

#ssh client configuration
# PasswordAuthentication no
# IdentityFile ~/.ssh/school

file { '/etc/ssh/ssh_config.d/school.conf':
  ensure  => file,
  content => "\nPasswordAuthentication no\nIdentityFile ~/.ssh/school\n",
  notify  => Exec['ssh_reload'],
}

exec { 'ssh_reload':
  command => '/usr/sbin/service ssh reload'
}

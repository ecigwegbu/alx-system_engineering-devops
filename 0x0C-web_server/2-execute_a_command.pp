# This puppet manifest kills a process
exec { 'killmenow':
  command => '/usr/bin/pkill -u root killmenow'
}

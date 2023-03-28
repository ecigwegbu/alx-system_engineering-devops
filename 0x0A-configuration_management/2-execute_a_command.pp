# This puppet manifest kills a process
exec { 'killmenow':
  command => 'pkill -u root killmenow'
}

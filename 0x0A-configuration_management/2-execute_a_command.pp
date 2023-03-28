# This puppet manifest kills a process
exec { 'killmenow':
  command => 'pkill --signal 9 killmenow'
}

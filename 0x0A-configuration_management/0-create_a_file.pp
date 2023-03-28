# This puppet manifest creates a file in /tmp
file { 'create_a_file':
  path    => '/tmp/school',
  mode    => '0744',
  owner   => www-data,
  group   => www-data,
  content => 'I love Puppet'
}

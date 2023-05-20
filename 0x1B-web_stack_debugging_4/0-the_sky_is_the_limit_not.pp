# Set ULIMIT to make 2000 requests to my server with 100 requests at a time

exec { 'update_ulimit':
  command => '/bin/sed -i "s/n 15/n 2048/g" /etc/default/nginx',
}

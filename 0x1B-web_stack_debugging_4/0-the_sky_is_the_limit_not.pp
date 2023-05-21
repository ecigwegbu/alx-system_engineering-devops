# Puppet manifest to Set ULIMIT to make 2000 requests to my
# server with 100 requests at a time

exec { 'update_ulimit':
  command => '/bin/sed -i -E "s/^(ULIMIT=.*)$/ULIMIT=\"-n 256\"/g" \
  /etc/default/nginx',
}

# Reload the nginx configuration
-> exec { 'reload_nginx':
  command => '/usr/sbin/service nginx restart',
}

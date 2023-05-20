# Puppet manifest to stop apache benchmark error on nginx server.
# Increase the ULIMIT default value in /etc/default/nginx
# Determine dthat 256 is good for up to 2000 requests @ 100 concur.
# ab -c 10 -n 2000 localhost/ | grep 'Failed requests:'

exec { 'increase_ULIMIT':
  command => '/bin/sed -i "s/15/256/g" nginx',
}

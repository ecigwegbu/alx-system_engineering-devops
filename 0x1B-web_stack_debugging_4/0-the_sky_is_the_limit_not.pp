# Puppet manifest to stop apache benchmark error on nginx server.
# ab -c 10 -n 1000 localhost/ | grep 'Failed requests:'

# increase # of worker processes:
exec { 'increase_worker_processes':
  command => '/bin/sed -i --follow-symlinks "s/worker_processes 4/worker_processes 8/g" \
    /etc/nginx/nginx.conf',
}

# increase # of worker connections:
-> exec { 'increase_worker_connections':
  command => '/bin/sed -i --follow-symlinks "s/worker_connections 768/worker_connections 1000/g" \
    /etc/nginx/nginx.conf',
}

# uncomment multi_access on:
-> exec { 'uncomment_multi_acess_on':
  command => '/bin/sed -i --follow-symlinks "s/\# multi_accept on/multi_accept on/g" \
    /etc/nginx/nginx.conf',
}

# restart nginx:
-> exec { 'restart_nginx':
  command => '/usr/bin/service nginx restart',
}

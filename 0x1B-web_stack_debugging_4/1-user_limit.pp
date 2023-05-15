# Change the OS configuration so that it is possible to login with the
# holberton user and open a file without any error message

# increase number of files limits hard and soft:

exec { 'increase_hard_nofile':
  command => '/bin/sed -i --follow-symlinks "s/holberton hard nofile 5/holberton hard nofile 2048/g" \
    /etc/security/limits.conf',
}

-> exec { 'increase_soft_nofile':
  command => '/bin/sed -i --follow-symlinks "s/holberton soft nofile 4/holberton soft nofile 1024/g" \
    /etc/security/limits.conf',
}

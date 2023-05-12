# puppet manifest to find out why Apache is returning a 500 error.

# replace bad file extension phpp with php:
exec { 'sed_repl_phpp':
  command => '/bin/sed -i --follow-symlinks "s/phpp/php/g" \
    /var/www/html/wp-settings.php',
}

# puppet manifest to find out why Apache is returning a 500 error.
# First rename the index.php that is causing wahalla :)
file { '/var/www/html/index.php':
  ensure  => absent
}

# Then add a placeholder while I figure out what is wrong! :)
file { '/var/www/html/index.html':
  ensure  => file,
  mode    => '0755',
  owner   => 'www-data',
  group   => 'www-data',
  content => '<html><body>#Do.Hard.Things! :)</body></html>'
}

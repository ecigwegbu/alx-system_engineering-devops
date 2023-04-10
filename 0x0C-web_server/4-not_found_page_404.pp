# Not found page 404
file { '/usr/share/nginx/html/error404.html':
  path    => '/usr/share/nginx/html/error404.html',
  mode    => '0644',
  content => "Ceci n'est pas une page

",
  notify  => Exec['404_not_found'],
}
exec { '404_not_found':
  command => '/usr/bin/sed -i --follow-symlinks "s/^\s*server_name _;/\tserver_name _;\n\
        error_page 404 \/error404.html;\n\
        location = \/error404.html \{\n\
                root \/usr\/share\/nginx\/html;\n\
                internal;\n\
        \}/" \
    /etc/nginx/sites-enabled/default',
  notify  => Service['nginx'],
}

#service nginx reload
service { 'nginx':
  ensure  => running,
  enable  => true,
#  require => Package['nginx'],
}

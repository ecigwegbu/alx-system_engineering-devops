# Redirection - 301
exec { 'sed_redirection_301':
  command => '/usr/bin/sed -i --follow-symlinks \
    "s/^\s*server_name _;/\tserver_name _;\n\trewrite \/redirect_me \
     \'https:\/\/www.youtube.com\/watch?v=QH2-TGUlwu4\' permanent;/" \
    default',
#  require => Exec['sed_rem_prev_redirect'],
}

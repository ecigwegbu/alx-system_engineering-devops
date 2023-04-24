#!/usr/bin/env bash
# install nginx on a new ubuntu server, with custom nginx header

# add redirect line
line1="\tserver_name _;"
line2="\trewrite \/redirect_me"
newurl="https:\/\/www.youtube.com\/watch?v=QH2-TGUlwu4"
sed  --follow-symlinks "s/^\s*server_name _;/$line1\n$line2 $newurl permanent;/" \
        /etc/nginx/sites-enabled/default


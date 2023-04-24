#!/bin/bash

# First, remove any previous redirect:
# sed -i --follow-symlinks "s/^\s*rewrite \/redirect_me.*$//g" \
#        /etc/nginx/sites-enabled/default
# add  lines
line1="\tserver_name _;"
line2="        location \/ "
line3="        location \/hbnb_static\/ "
line4="                alias \/data\/web_static\/current/;"
line5="        "
sed --follow-symlinks "s/^\s*server_name _;/$line1\n$line2\n$line3\n$line4\n$line5;/" \
        /etc/nginx/sites-enabled/default

#        location /hbnb_static/ {
#                alias /data/web_static/current/;
#        }
root@ubuntu22:/alx-system_engineering-devops# cat test2.sh
#!/usr/bin/env bash
# install nginx on a new ubuntu server, with custom nginx header

# add redirect line
line1="\tserver_name _;"
line2="\trewrite \/redirect_me"
newurl="https:\/\/www.youtube.com\/watch?v=QH2-TGUlwu4"
sed  --follow-symlinks "s/^\s*server_name _;/$line1\n$line2 $newurl permanent;/" \
        /etc/nginx/sites-enabled/default

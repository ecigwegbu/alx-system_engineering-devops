#!/usr/bin/env bash
line1="\tserver_name _;"
line2="\trewrite \/redirect_me https:\/\/www.youtube.com\/watch?v=QH2-TGUlwu4 permanent;"

#sed -i -E "s/^[[:blank:]]server_name _;/$line1\n$line2/" test1
sed -i  "s/^[[:blank:]]server_name _;/$line1\n$line2/" test1

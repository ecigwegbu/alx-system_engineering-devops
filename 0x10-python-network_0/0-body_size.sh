#!/bin/bash
# This bash script takes in a URL, sends a request to that URL,
# and displays the size of the body of the response

# $1 - first argument
echo "$1"
curl "$1" -o testFile 2> /dev/null
wc testFile -c | cut -f1 -d' '

#!/bin/bash

for url in $*
do
    echo $url
    check-url.sh $url | grep -e ^HTTP -e^URL-Effective: -e^Error: | sed 's/^URL-Effective: //' | sed 's/^/ /'
done

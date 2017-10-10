#!/bin/bash

for url in $*
do
    echo $url
    check-url.sh $url 2>&1 | grep -e '^< HTTP' -e^URL-Effective: -e^Error | sed 's/^URL-Effective: //' | sed 's/^/   /'
done

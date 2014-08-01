#!/bin/bash
#curl-full.sh - Uses curl to check the HTTP headers of a URL, including every hop of any redirects
#Author: Jason Dew
#Date: 2013-06-19


CURL_CMD=/usr/bin/curl
CURL_OPT="-s -I -L -w \"URL-Effective: %{url_effective}\ntime_total: %{time_total}\""
SEC_OPT="-k"

while getopts ":s" OPT; do
    case $OPT in
        s)
            SEC_OPT=""
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            echo "Usage: `basename $0` [-s] URL"
            exit 1
            ;;
    esac
done

#curl -s -m 20 -I -L -k -w "URL-Effective: %{url_effective}\ntime_total: %{time_total}" $1
#curl -s -I -L -k -w "URL-Effective: %{url_effective}\ntime_total: %{time_total}" $1
#echo "Running: $CURL_CMD $CURL_OPT $BASH_ARGV"
#$CURL_CMD $CURL_OPT $BASH_ARGV

#####DEBUG#####
echo "\$BASH_ARGV: $BASH_ARGV"
#####DEBUG#####

curl -s -I -L $SEC_OPT -w "URL-Effective: %{url_effective}\ntime_total: %{time_total}" $BASH_ARGV
EXIT_STATUS=$?

#needs a trailing newline
echo
echo

case $EXIT_STATUS in
0 )
	#no errors, do nothing
	#echo "exit 0"
	;;
6 )
	echo "Error: Couldn't resolve host. The given remote host was not resolved."
	;;
7 )
	echo "Error: Failed to connect to host"
	;;
28 )
	echo "Error: Operation timeout. The specified time-out period was reached according to the conditions."
	;;
47 )
	echo "Error: Too many redirects. When following redirects, curl hit the maximum amount."
	;;
52 )
	echo "Error: The server didn't reply anything, which here is considered an error."
	;;
56 )
	echo "Error: Failure in receiving network data."
	;;
60 )
	echo "Error: Problem with the CA cert (path? permission?)"
	;;
* )
	#Un-caught error code
	echo "Error: Unknown error, curl exit code $EXIT_STATUS"
	;;
esac

exit $EXIT_STATUS

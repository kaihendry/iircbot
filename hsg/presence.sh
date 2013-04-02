#!/bin/bash

tail -f /var/log/freeradius/radacct/49.128.60.116/detail-$(date +%Y%m%d) |
while read field _ value
do
    value=$(echo "$value" | tr -d '"')

    case "$field" in
        Framed-IP-Address)
            ip="$value"
            ;;

        Acct-Status-Type)
            status="$value"
            ;;

        Calling-Station-Id)
            mac=$(sed -re 's/([0-9A-Z]{2})/\1:/g; s/(:$|\.)//g' <<< "$value")
            desc=$(grep $mac presence.table)
            test "$desc" || desc="$mac"
            ;;
    esac

    test "$field" || echo "$ip $status $desc" >> ~/irc/irc.freenode.net/#hackerspacesg/in
done

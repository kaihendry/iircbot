#!/bin/bash

exec 1>>$HOME/irc/irc.freenode.net/#hackerspacesg/in

tail -f /var/log/freeradius/radacct/49.128.60.116/detail-$(date +%Y%m%d) | \
    while read field eq value;
do

    [ "$eq" != '=' ] && [ -n "$field" ] && continue;

    value=$(sed -e 's/"//g' <<< "$value");

    case "$field" in
        Framed-IP-Address)
            ip="$value";
            ;;

        Acct-Status-Type)
            status="$value";
            ;;

        Calling-Station-Id)
            mac=$(sed -re 's/([0-9A-Z]{2})/\1:/g; s/(:$|\.)//g' <<< "$value");
            desc=$(sed -n "s/^$mac //p" presence.table)

            [ -z "$desc" ] && desc="$mac";
            ;;
    esac

    [ -z "$field" ] && echo "$ip $status $desc"
done

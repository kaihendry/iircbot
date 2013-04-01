#!/usr/bin/env bash
# thanks to dualbus on #bash for reviewing this


#cat report-eg | while read -r report
nmap -sP 192.168.5.* | while read -r report
do
	case $report in
	"Nmap scan report for"*)
		read -r _ _ _ _ IP _ <<< "$report"
		read -r _ name <<< "$(avahi-resolve-address $IP 2>/dev/null)"
		;;
	"MAC Address"*)
		read -r _ _ mac _ _ _ <<< "$report"
		echo $mac $name
		;;
	*)
		;;
	esac
done

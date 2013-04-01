nmap -sP 192.168.5.* | while read -r report
do
	case $report in
	"Nmap scan report for"*)
		IP=$(echo $report | cut -d" " -f5)
		name=$(avahi-resolve-address $IP 2>/dev/null | awk '{print $2}')
		;;
	"MAC Address"*)
		mac=$(echo $report | cut -d" " -f3)
		echo $mac $name
		;;
	*)
		;;
	esac
done

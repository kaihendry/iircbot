#cat /var/log/freeradius/radacct/49.128.60.116/detail-$(date +%Y%m%d) | while read -r foo
tail -f /var/log/freeradius/radacct/49.128.60.116/detail-$(date +%Y%m%d) | while read -r foo
do
case $foo in
Framed-IP-Address*)
	line="$(echo $foo | cut -d" " -f3)"
	;;
Acct-Status-Type*)
	line="$line $(echo $foo | cut -d" " -f3)"
	;;
Calling-Station-Id*)
	mac=$(sed -e 's/\(..\)\(..\)\.\(..\)\(..\)\.\(..\)\(..\)/\1:\2:\3:\4:\5:\6/' <<< $(echo $foo | cut -d" " -f3 | tr -d '"'))
	desc=$(grep $mac presence.table)
	if test "$desc"
	then
	line="$line $desc"
	else
	line="$line $mac"
	fi
	;;
*)
	;;
esac
test "$foo" || echo $line >> ~/irc/irc.freenode.net/#hackerspacesg/in
#test "$foo" || echo $line
done

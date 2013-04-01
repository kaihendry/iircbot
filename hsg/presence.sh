tail -f /var/log/freeradius/radacct/49.128.60.116/detail-20130401 | while read -r foo
do
case $foo in
Framed-IP-Address*)
	line="$(echo $foo | cut -d" " -f3)"
	;;
Acct-Status-Type*)
	line="$line $(echo $foo | cut -d" " -f3)"
	;;
Calling-Station-Id*)
	line="$line $(echo $foo | cut -d" " -f3)"
	;;
*)
	;;
esac
test "$foo" || echo $line >> ~/irc/irc.freenode.net/#hackerspacesg/in
done

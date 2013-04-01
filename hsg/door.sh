tail -n 0 -f /srv/www/hsgdoor.codersg.com/logs/hsgdoor-entry.log | stdbuf -o0 sed 's/^\[.*\]://' > ~/irc/irc.freenode.net/#hackerspacesg/in

#!/bin/bash

while [ /bin/true ]; do
	echo "starting `date`"
	silentjack -v -p 9 -g 3 /home/palacefm/scripts/silence_alert.sh
	DATEID=`date`
	ALERT=`echo -e "\nPalaceFM alert: WARNING $DATEIS\nsilentjack restarting\n\n\n\nGoodpie." | mail -s "PalaceFM silentjack restarted" andy.brown@palacefm.com`
	echo "RESTARTING `date`"
	sleep 5
done

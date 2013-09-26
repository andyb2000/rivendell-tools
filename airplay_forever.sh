#!/bin/bash

while [ /bin/true ]; do
	echo "starting `date`"
	echo "START: `date`" >> /home/palacefm/scripts/airplay.log
	/usr/bin/rdairplay --log1=`date +%Y_%m_%d`:+ >> /home/palacefm/scripts/airplay.log 2>&1
	echo "END: `date`" >> /home/palacefm/scripts/airplay.log
	DATEID=`date`
	ALERT=`echo -e "\nPalaceFM alert: WARNING $DATEIS\nrdairplay restarting\n\n\n\nGoodpie." | mail -s "PalaceFM rdairplay restarted" andy.brown@palacefm.com`
	echo "RESTARTING `date`"
	sleep 5
done

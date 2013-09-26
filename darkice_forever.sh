#!/bin/bash

while [ /bin/true ]; do
	ALERT=`echo -e "\nPalaceFM alert: WARNING $DATEIS\ndarkice restarting\n\n\n\nGoodpie." | mail -s "PalaceFM darkice restarted" andy.brown@palacefm.com`
	/usr/bin/darkice -v 5 -c /home/palacefm/.darksnow/darkice.cfg
	sleep 5
done


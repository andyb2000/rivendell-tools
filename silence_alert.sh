#!/bin/bash

DATEIS=`date`
echo -e "\nPalaceFM alert: Silence detection WARNING $DATEIS\nSound levels are too low for more than 7 seconds, please check the studio\n\n\n\nGoodpie." | mail -s "PalaceFM Silence Detection Alert (sj)" andy.brown@palacefm.com,dee.wold@palacefm.com

	DT=`date +"%T"`
	echo "LC red ALERT - $DT Silence detection !" > out.rml
	rmlsend --from-file=out.rml
	rm out.rml
	sleep 10
	rmlsend LB\ \!

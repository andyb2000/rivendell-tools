#!/bin/bash

rm -f /tmp/silence_detect.tmp
rm -f /tmp/blank.wav

ALERT_TIMES=5
ALERT_COUNT=0
FAULT_COUNTER=0
THRESHOLD=10

WARN[0]=0
WARN[1]=0
WARN[2]=0
date

while [ "$ALERT_COUNT" -lt "$ALERT_TIMES" ]
do
	rm -f /tmp/blank.wav >/dev/null 2>&1
	rm -f /tmp/silence_detect.tmp >/dev/null 2>&1
	READ_MICROPHONE=`arecord -vvv -f cd -c 2 -d 1 -D pcm.jack /tmp/blank.wav 2>&1 |grep "Max peak" | awk '{ print $7 }' | awk -F'%' '{print $1;}' > /tmp/silence_detect.tmp`
	largest2=0
	while read line2
	do
		if [ $line2 -ge $largest2 ]; then
		{
			largest2=$line2
		}
	fi
	done < /tmp/silence_detect.tmp

	echo "The largest number is : $largest2"
	if [ $largest2 -ge $THRESHOLD ]; then
		echo " Levels corrected. OK"
	else
		echo "      Levels still below threshold"
		WARN[$ALERT_COUNT]=$largest2
		FAULT_COUNTER=`expr $FAULT_COUNTER + 1`
	fi

	ALERT_COUNT=`expr $ALERT_COUNT + 1`
	sleep 2
done

if [ $FAULT_COUNTER -ge 2 ]; then
	echo "ALERT ALERT, more than 2 failures of silence!"
	DATEIS=`date`
	ALERT=`echo -e "\nPalaceFM alert: Silence detection WARNING $DATEIS\nSound levels detected (I tried 3 times):\n1: ${WARN[0]}\n2: ${WARN[1]}\n3: ${WARN[2]}\nThreshold is set at: $THRESHOLD\n\n\n\nGoodpie." | mail -s "PalaceFM Silence Detection Alert" andy.brown@palacefm.com,dee.wold@palacefm.com`
fi
echo "Found ${WARN[0]} then ${WARN[1]} then ${WARN[2]} done!"
echo "================================================================================="


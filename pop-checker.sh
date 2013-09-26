#!/bin/bash
# Wed Jun 16 16:04:19 EDT 2004
# NAME: p1
# Copyright 2004, Chris F.A. Johnson
# Released under the terms of the GNU General Public License

CR=$'\r'  ## carriage return; for removal of

## Get current pop3 number of messages
POPCOUNT=`cat .pop3_msg_counter`

## connect to POP3 server on local machine, port 110
exec 3<>/dev/tcp/lunar.broadcast-tech.co.uk/110

## get response from server
read ok line <&3

## check that it succeeded
[ "${ok%$CR}" != "+OK" ] && exit 5

## send user name, get response and check that it succeeded
echo user studio@palacefm.com >&3
read ok line <&3
[ "${ok%$CR}" != "+OK" ] && exit 5

## send password, get response and check that it succeeded
echo pass PASSWORD >&3
read ok line <&3
[ "${ok%$CR}" != "+OK" ] && exit 5

## get number of messages
echo stat >&3
read ok num x <&3

## display number of messages
echo $num messages

## store current number to compare
echo $num > .pop3_msg_counter

## Compare and exec if number of messages changed
if [ $POPCOUNT -ne $num ]; then
	echo "POP count changed"
	DT=`date +"%d/%m\ %T"`
	echo "LC red $DT NEW STUDIO EMAIL !" > out.rml
	rmlsend --from-file=out.rml
	rm out.rml
	sleep 60
	rmlsend LB\ \!
fi

## close connection
echo quit >&3

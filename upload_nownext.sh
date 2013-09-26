#!/bin/bash

## Just upload the now/next to the website if its changed

## Check md5 comparison

if [ -f /tmp/nowplaying.md5 ]; then
	NOW_MD5=`/usr/bin/md5sum /home/palacefm/nowplaying.txt`
	OLD_MD5=`cat /tmp/nowplaying.md5`
	if [ "$NOW_MD5" == "$OLD_MD5" ]; then
		## no change
		echo "No change, skipping update"
		exit 0
	else
		## changed, do update
		echo "Changed, updating via ftp"
	fi
else
	echo "First run, updating via ftp"
	CURR_MD5=`/usr/bin/md5sum /home/palacefm/nowplaying.txt > /tmp/nowplaying.md5`
fi

## If we get here we should ftp the update

ftp -inv lunar.broadcast-tech.co.uk << EOF
user palaceplayout PASSWORD
cd web
put /home/palacefm/nowplaying.txt nowplaying.txt
bye

EOF

echo "Complete"


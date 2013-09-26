#!/bin/bash

while [ /bin/true ]; do

#	/usr/local/bin/calfjackhost Compressor:palacefm 
	/usr/local/bin/calfjackhost "MultibandLimiter:palacefm" "Compressor:palacefm"
	sleep 5
done


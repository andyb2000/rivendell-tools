#!/bin/bash

## weekly schedule generated, runs on a Saturday
echo "Starting weeks schedule generation"

## sunday
/usr/bin/rdlogmanager -g -d 0 -s Production
## monday
/usr/bin/rdlogmanager -g -d 1 -s Production
## tuesday
/usr/bin/rdlogmanager -g -d 2 -s Production
## wednesday
/usr/bin/rdlogmanager -g -d 3 -s Production
## thursday
/usr/bin/rdlogmanager -g -d 4 -s Production
## friday
/usr/bin/rdlogmanager -g -d 5 -s Production
## saturday
/usr/bin/rdlogmanager -g -d 6 -s Production

echo "Done for the week"

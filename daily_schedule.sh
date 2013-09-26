#!/bin/bash

## daily schedule generator for tomorrow
echo "Starting daily schedule generation"

/usr/bin/rdlogmanager -g -d 0 -s Production
## next day
/usr/bin/rdlogmanager -g -d 1 -s Production

echo "Done for daily"

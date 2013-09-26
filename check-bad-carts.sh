#!/bin/bash

## simply check for carts with non ascii characters

mysql -u rduser --password=PASS Rivendell --execute="select NUMBER,TITLE,ARTIST,ALBUM from CART where not ARTIST REGEXP \"[A-Za-z0-9,']\" and ARTIST <> '';"
mysql -u rduser --password=PASS Rivendell --execute="select NUMBER,TITLE,ARTIST,ALBUM from CART where not TITLE REGEXP \"[A-Za-z0-9,']\";"

#!/usr/bin/python
# -*- coding: utf-8 -*-

import MySQLdb as mdb
import datetime
import subprocess
import sys,  os

con = None
host = 'localhost'
user = 'rduser'
upword = 'letmein'
dbase = 'Rivendell'
## Where to get your fill songs
##Make sure all the quotes arre there
musicGroups = " 'CrnkdMusic', 'CrnkTemp' "
## Where to get your sweepers, jingles, splitters
sweeperGroups = " 'Sweepers' "
hourNow = datetime.datetime.now().hour
minNow = datetime.datetime.now().minute
secNow = datetime.datetime.now().second
##Change the 60 to what ever minute in the hour your want to fill to
secFromTop = ((minNow*60)+secNow)*1000
secLeft = ((60*60*1000)-secFromTop)
## Average size of Previous Sweeper in millisec
drift = 4000
## Plus/Minus song size in millisec
margin = 1750
secLeft = secLeft-drift

## Number of songs to pick
if secLeft < 360000 :
     songCount = 1
elif (secLeft > 360000) & (secLeft < 540000 ):
    songCount = 2
elif (secLeft > 540000) & (secLeft < 780000 ):
    songCount = 3
elif (secLeft > 780000) & (secLeft < 960000 ):
    songCount = 4
elif (secLeft > 960000) & (secLeft < 1080000 ):
    songCount = 5
elif (secLeft > 1080000) & (secLeft < 1440000 ):
    songCount = 6
elif (secLeft > 1440000) & (secLeft < 1800000 ):
    songCount = 7
else:
     songCount = 8

try:
     con = mdb.connect(host,  user,  upword,  dbase);
     cur = con.cursor()
     if songCount == 1:
         cur.execute("select number, average_length from Rivendell.CART where average_length between {0} and {1} and GROUP_NAME in ({2}) order by Rand() limit 1".format((secLeft-margin),  (secLeft+margin), musicGroups))
         data = cur.fetchone()
         subprocess.call (["rmlsend", "--to-host=localhost"," PX 1 {0}!".format(data[0])])

     elif songCount > 1:
         songs = ((songCount*2)-1)
         for i in range(songs):
             if i%2==0:
                 cur.execute("select number, average_length from Rivendell.CART where average_length between {0} and {1} and GROUP_NAME in ({2}) order by Rand() limit 1".format(((secLeft/songCount)-margin), ((secLeft/songCount)+margin), musicGroups))
                 data = cur.fetchone()
                 secLeft = secLeft-data[1]
                 subprocess.call (["rmlsend", "--to-host=localhost"," PX 1 {0}!".format(data[0])])
                 songCount=songCount-1
             else:
                 cur.execute("select number, average_length from Rivendell.CART where GROUP_NAME in ({0}) order by Rand() limit 1".format(sweeperGroups))
                 data = cur.fetchone()
                 secLeft = secLeft-data[1]
                 subprocess.call (["rmlsend", "--to-host=localhost"," PX 1 {0}!".format(data[0])])

except mdb.Error,  e:

     print "Error %d: %s" % (e.args[0], e.args[1])
     sys.exit(1)

finally:
     if con:
         con.close()

#!/bin/bash
/usr/bin/xmessage -buttons WAIT "Loading rivendell studio software" -center -timeout 40 &
sudo service rivendell stop
/usr/lib/vino/vino-server &
sleep 5
# screen -DmS jack jackd -dalsa -dhw:0 -r48000 -p256 -n3 -s &
##screen -DmS jack jackd -dalsa -dhw:0 -r48000 -p256 -n3 -s &
#screen -DmS jack /usr/bin/jackd -p128 -dalsa -dhw:0 -r48000 -p256 -n2 -s -P &
sudo killall jackd
screen -DmS jack /usr/bin/jackd -T -ndefault -p128 -dalsa -dhw:0 -r48000 -p256 -n2 -s &
sleep 10
/usr/bin/qjackctl &
#sleep 3
# start the extra sound card
alsa_in -r 48000 -p 256 -n 3 -d hw:1 >/dev/null 2>&1 &
alsa_out -r 48000 -p 256 -n 3 -d hw:1 >/dev/null 2>&1 &
sleep 5
service rivendell start
sleep 15
screen -DmS darkice /home/palacefm/scripts/darkice_forever.sh &
#screen -DmS darkice /home/palacefm/scripts/darkice_TEST_forever.sh &
sleep 5
screen -DmS calfjackhost /home/palacefm/scripts/calf_forever.sh &
screen -DmS airplay /home/palacefm/scripts/airplay_forever.sh &
screen -DmS silentjack /home/palacefm/scripts/silentjack_forever.sh &
# /usr/bin/rdairplay --log1=`date +%Y_%m_%d`:+ &
service ntp restart
sudo alsactl restore

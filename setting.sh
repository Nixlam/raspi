#!/bin/bash

echo "Start setting....."
# sudo apt update
# sudo apt upgrade
#sudo apt install pigpio python3-pigpio
#sudo systemctl enable pigpiod.service
#sudo systemctl start pigpiod
#echo 'm 17 w   w 17 0   m 18 r   pud 18 u' > /dev/pigpio

if [[ $(crontab -l | grep "hello" | wc -l) = "0" ]] ; then
	echo "It's not there"
else
	echo "It's already there"
fi

crontab -l > mycron
echo new cron into cron file
echo "00 09 * * 1-5 echo hello" >> mycron
# install new cron file
crontab mycron
rm mycron

echo "Finish"

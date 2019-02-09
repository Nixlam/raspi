#!/bin/bash

echo "Start setting....."

# pigpioのインストール
sudo apt update
sudo apt upgrade
sudo apt install pigpio python3-pigpio
sudo systemctl enable pigpiod.service
sudo systemctl start pigpiod

# cronが存在するか確認する。なければcronを作成する
if [ $(crontab -l | grep "no crontab" | wc -l) = "1" ]
then
	echo "no crontab. Make new crontab"
	crontab -l 2>/dev/null | crontab -
fi

# cronにGPIOの設定を追加（ラズパイ起動時に自動で実行される）
setting_command="@reboot until echo 'm 17 w   w 17 0   m 18 r   pud 18 u' > /dev/pigpio; do sleep 1s; done"

if [ $(crontab -l | grep "/dev/pigpio" | wc -l) = "0" ]
then
	echo "It's not there. Add command to cron."
	crontab -l > tmpcron
	# "コマンドを一時ファイルに追加"
	echo $setting_command >> tmpcron
	# 一時ファイルを上書き
	crontab tmpcron
	rm tmpcron
else
	echo "It's already there. Not add command."
fi

echo "Finish"

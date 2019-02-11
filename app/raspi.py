import os
from datetime import datetime
import time
import RPi.GPIO as GPIO
import settings.py

print(os.environ.get("MOTION_SENSOR_GPIO_PIN"))

# インターバル
INTERVAL = 3
# スリープタイム
SLEEPTIME = 3
# 使用するGPIO
GPIO_PIN = 18

GPIO.setmode(GPIO.BCM)
GPIO.setup(GPIO_PIN, GPIO.IN)

if __name__ == '__main__':
    try:
        print ("処理キャンセル：CTRL+C")
        cnt = 1
        while True:
            # センサー感知
            if(GPIO.input(GPIO_PIN) == GPIO.HIGH):
                print(datetime.now().strftime('%Y/%m/%d %H:%M:%S') +
                "：" + str("{0:05d}".format(cnt)) + "回目の人感知")
                cnt = cnt + 1
                time.sleep(SLEEPTIME)
            else:
                # print(GPIO.input(GPIO_PIN))
                print('感知なし・・・')
                time.sleep(INTERVAL)
    except KeyboardInterrupt:
        print("終了処理中...")
    finally:
        GPIO.cleanup()
        print("GPIO clean完了")

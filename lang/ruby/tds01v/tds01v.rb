# -*- coding: utf-8 -*-

require 'fcntl'
require 'termios'
include Termios

DEVICE = '/dev/tty.usbserial-00001004'
BAUDRATE = B9600

dev = dev_open(DEVICE)

# % cu -s 9600 -l /dev/tty.usbserial-0000103D
# Connected.
# 050027950000<ENTER><ENTER>
# FA
# 0DF7<ENTER><ENTER>
# F2
# 27<ENTER><ENTER>
# D8
# 21<ENTER><ENTER>
# DE
# 29<ENTER><ENTER>
# FE8500A000A407B900050006FFB80024FFE527AEFFEB00D50B1B
# 21<ENTER><ENTER>
# DE
# 29<ENTER><ENTER>
# FE81009400A807B400020002FFB7000BFFF527B2FFE800D50B1B
# ~.

# akio0911:~# ls /dev/tty.usb*
# /dev/tty.usbserial-00001004
# akio0911:~# cu -s 9600 -l /dev/tty.usbserial-00001004 
# Connected.

# REQ 050027950000 # 計測条件設定
# RES FA # ACK 計測条件設定応答

# REQ 0DF7 # センサ情報項目設定 全センサ全データ(ベクトルデータ+計測データ)
# RES F2 # ACK センサ情報項目設定応答

# REQ 27 # 地磁気センサ初期化要求
# RES D8 # ACK 地磁気センサ初期化要求応答

# REQ 21 # 計測開始
# RES DE # ACK 計測開始応答


# REQ 29 # センサ情報要求
# RES 0042 007D FDE5 0B7C 0004 0011 FFB8 0060 FFEC 27B7 FFE4 0137 0B17 # センサ情報 全センサ全データ(ベクトルデータ+計測データ)

# REQ 21 # 計測開始
# RES DE # ACK 計測開始応答

# REQ 29 # センサ情報要求
# RES 0042 007D FDED 0C2C 0004 FFFB FFB1 FFE5 FFEA 27B8 FFE3 0137 0B17 # センサ情報 全センサ全データ(ベクトルデータ+計測データ)

# ~.

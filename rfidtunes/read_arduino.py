import serial
import os
ser = serial.Serial('/dev/tty.usbserial-A6008iaz')
ser.baudrate = 2400
while 1:
  s = ser.read(15)
#  if line != "":
#      print line
  print s
  os.system("open -a itunes  http://streamer-ntc-aa01.somafm.com:80/stream/1021")

ser.close()

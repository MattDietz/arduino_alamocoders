import serial
import os
ser = serial.Serial('/dev/tty.usbserial-A6008iaz')
ser.baudrate = 2400

auth = "code:0415ED3467"

while 1:
  s = ser.read(15)
  if s == auth:
    print "authorized %s" % s
    os.system("open -a itunes '/Users/pvoccio/Music/iTunes/iTunes Music/Mumford & Sons/Sigh No More/01 Sigh No More.mp3'") 
  else:
    print "rejected %s" % s
  
  ser.flushInput()


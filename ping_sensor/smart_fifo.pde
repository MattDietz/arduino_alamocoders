/*
  A really absurd class. First attempts to list and utilize the serial port requested.
  
  If that's not found, looks for a file on disk denoted by fifoPath. Hopefully you either made a 
  fake serial port or used mkfifo.
  
  Failing both of those, just generate a random int and throw it back
*/
class SmartFifo {
  Serial serialPort;
  InputStream fifo;
  
  SmartFifo(PApplet parent, String serialName, String fifoPath) {
    serialPort = setupSerial(parent, serialName);
    if (serialPort == null)
      fifo = createInput(fifoPath); 
  }
  
  Serial setupSerial(PApplet parent, String serialName) {
    String serialList[] = Serial.list();
    for(int i = 0; i < serialList.length; ++i) {
      if (serialList[i].equals(serialName)) {
        return new Serial(parent, Serial.list()[i], 9600);         
      } 
    }
    return null;
  }
  
  int read() {
    if (serialPort != null) {
      int val = serialPort.read();
      println(val);
      return val;
    }
    if (fifo != null) {
      try { 
        return fifo.read();
      } catch (IOException e) {
        return -1; 
      }
    }
    else
      return int(random(254)+1);
  } 
}

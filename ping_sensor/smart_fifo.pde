class SmartFifo {
  Serial serialPort;
  InputStream fifo;
  
  SmartFifo(PApplet parent, String serialName, String path) {
    serialPort = setupSerial(parent, serialName);
    if (serialPort == null)
      fifo = createInput(path); 
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
      return int(random(99)+1);
  } 
}

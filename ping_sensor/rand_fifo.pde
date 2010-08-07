class RandFifo {
  InputStream fifo;
  
  RandFifo(String path) {
    fifo = createInput(path); 
  }
  
  int read() {
    if (fifo != null) {
      try { 
        return fifo.read();
      } catch (IOException e) {
        return -1; 
      }
    }
    else
      return int(random(199)+1);
  } 
}

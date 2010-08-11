// RFID reader for Arduino 
// Wiring version by BARRAGAN <http://people.interaction-ivrea.it/h.barragan> 
// Modified for Arudino by djmatic


#include "WProgram.h"
void setup();
void loop();
int  val = 0; 
char code[10]; 
int bytesread = 0; 

void setup() { 

Serial.begin(2400); // RFID reader SOUT pin connected to Serial RX pin at 2400bps 
pinMode(2,OUTPUT);   // Set digital pin 2 as OUTPUT to connect it to the RFID /ENABLE pin 
digitalWrite(2, LOW);                  // Activate the RFID reader
}  


 void loop() { 

  if(Serial.available() > 0) {          // if data available from reader 
    if((val = Serial.read()) == 10) {   // check for header 
      bytesread = 0; 
      while(bytesread<10) {              // read 10 digit code 
        if( Serial.available() > 0) { 
          val = Serial.read(); 
          if((val == 10)||(val == 13)) { // if header or stop bytes before the 10 digit reading 
            break;                       // stop reading 
          } 
          code[bytesread] = val;         // add the digit           
          bytesread++;                   // ready to read next digit  
        } 
      } 
      if(bytesread == 10) {              // if 10 digit read is complete 
        Serial.print("code:");        // possibly a good TAG 
        Serial.println(code);        // print the TAG code 

        delay(5000);
        Serial.flush();
      } 
      bytesread = 0; 
           delay(500);                       // wait for a second 
    } 
  } 
} 

// extra stuff
// digitalWrite(2, HIGH);             // deactivate RFID reader 



int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}


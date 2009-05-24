
#include "WProgram.h"
void setup();
void loop();
int i, j;
int inByte = 0;


void setup() {
  DDRD = DDRD | B11111100;
  
  Serial.begin(9600);
}


void loop() {
  if (Serial.available() > 0) {
    inByte = Serial.read();
    Serial.println(inByte, BIN);
  }
  
  // clear direction bit from 2 to 7
  PORTD = PORTD & B00000011;
  PORTD = PORTD | inByte;
  Serial.println(PORTD, BIN);
  delay(500);
}
int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}


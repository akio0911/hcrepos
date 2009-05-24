
#include "WProgram.h"
void setup();
void loop();
int i, j;

void setup() {
  DDRD = DDRD | B11111100;
  
  Serial.begin(9600);
}


void loop() {
  for (i=0; i < 64; i++) {
    PORTD = PORTD & B00000011;
    j = (i << 2);
    
    PORTD = PORTD | j;
    
    Serial.println(PORTD, BIN);
    delay(500);
  }
}
int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}


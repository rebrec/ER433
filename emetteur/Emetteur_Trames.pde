/*
  Example for different sending methods
  
  http://code.google.com/p/rc-switch/
  
  Need help? http://forum.ardumote.com
*/

#include <RCSwitch.h>
#define TRANSMIT_PIN 10

#define CHAN_A "00101010"
#define CHAN_B "10001010"
#define CHAN_C "10100010"
#define CHAN_D "10101000"

#define PRISE_1 "001010"
#define PRISE_2 "100010"
#define PRISE_3 "101000"

#define PADDING_START "000000000"
#define PADDING_MIDDLE "1010101"

#define CMD_ON "11"
#define CMD_OFF "00"


RCSwitch mySwitch = RCSwitch();

void setup() {

  Serial.begin(9600);
  
  // Transmitter is connected to Arduino Pin #10  
  mySwitch.enableTransmit(TRANSMIT_PIN );

  // Optional set pulse length.
  // mySwitch.setPulseLength(320);
  
  // Optional set protocol (default is 1, will work for most outlets)
  // mySwitch.setProtocol(2);
  
  // Optional set number of transmission repetitions.
   mySwitch.setRepeatTransmit(1);
  
}

void loop()
{

	Serial.println(PADDING_START CHAN_C PRISE_2 PADDING_MIDDLE CMD_ON);
  mySwitch.send(PADDING_START CHAN_C PRISE_2 PADDING_MIDDLE CMD_ON);
  delay(20); 
  mySwitch.send(PADDING_START CHAN_C PRISE_2 PADDING_MIDDLE CMD_ON);
  
  delay(2000); 
  Serial.println(PADDING_START CHAN_C PRISE_2 PADDING_MIDDLE CMD_OFF);
  mySwitch.send(PADDING_START CHAN_C PRISE_2 PADDING_MIDDLE CMD_OFF);
  delay(2000); 

}
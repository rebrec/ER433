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

//#define PADDING_START "000000000"
#define PADDING_START "0"
#define PADDING_MIDDLE "1010101"

#define CMD_ON "11"
#define CMD_OFF "00"


RCSwitch mySwitch = RCSwitch();


// genere la trame au format binaire à passer à RCSwitch.send(char*) 
// sChan correspond au Channel paramétré sur la prise ("A","B","C","D")    a=1,b=2 etc car je n'arrive pas à le faire avec des char...
// nPrise correspond au numero de la prise (1,2,3)
char* genCastoTrame(int sChan, int nPrise, boolean bStatus){ 
  static char sReturn[25];
  String res;
  res = String();
  res = PADDING_START;

  switch(sChan){
      case 1:
          res = res + CHAN_A; break;
      case 2:
          res = res +  CHAN_B; break;
      case 3:
          res = res + CHAN_C; break;
      case 4:
          res = res +  CHAN_D; break;
      default:
          return '\0';
  }
  switch (nPrise){
      case 1:
          res = res + PRISE_1; break;
      case 2:
          res = res +  PRISE_2; break;
      case 3:
          res = res + PRISE_3; break;
      default:
          return '\0';
  }
  res = res + PADDING_MIDDLE;
  switch(bStatus){
      case true:
          res = res + CMD_ON; break;
      case false:
          res = res +  CMD_OFF; break;
      default:
          return '\0';
  }
  res.toCharArray(sReturn,25);
  return sReturn;  


}



void setup() {

  Serial.begin(9600);
  
  // Transmitter is connected to Arduino Pin #10  
  mySwitch.enableTransmit(10 );

  
  // Optional set protocol (default is 1, will work for most outlets)
  mySwitch.setProtocol(1);

  // Optional set pulse length.
  mySwitch.setPulseLength(308);
  
  // Optional set number of transmission repetitions.
  // mySwitch.setRepeatTransmit(1);
  
}

void loop()
{
  mySwitch.send(genCastoTrame(3,2,true));// envoie ON sur le Chanel C (3) prise 2
  delay(2000); 
  mySwitch.send(genCastoTrame(3,2,false));// envoie OFF sur le Chanel C (3) prise 2
  delay(2000); 
  
}


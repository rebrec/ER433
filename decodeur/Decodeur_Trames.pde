/*
  Simple example for receiving
  
  http://code.google.com/p/rc-switch/
  
  Need help? http://forum.ardumote.com
*/

#include <RCSwitch.h>

RCSwitch mySwitch = RCSwitch();

static unsigned long lastVal;
static unsigned long curVal;

void setup() {
  Serial.begin(9600);
  mySwitch.enableReceive(0);  // Receiver on inerrupt 0 => that is pin #2
  Serial.println("salut gringo");
}

void loop() {
  static  unsigned long curT;
  static  unsigned long lastT;
  if (mySwitch.available()) {
    curT = millis();
    Serial.print("delta : ");
    Serial.println(curT-lastT);

    lastT = curT;
    int value = mySwitch.getReceivedValue();
    
    if (value == 0) {
      Serial.print("Unknown encoding");
    } else {
      curVal =  mySwitch.getReceivedValue();
      //Serial.print("Received     : ");
      //Serial.println(curVal);
      Serial.print("Received BIN : ");
      //Serial.println( curVal, BIN );
      print_binary(curVal,32);
      Serial.print("\n");
//    Serial.print("Diff         : ");
//      Serial.print( mySwitch.getReceivedBitlength() );
//      Serial.print("bit ");
//      Serial.print("Protocol: ");
//      Serial.println( mySwitch.getReceivedProtocol() );
//      print_binary(lastVal ^ curVal,32);
//      Serial.print("\n");
//    //Serial.println(lastVal ^ curVal, BIN);
      Serial.println("--------");
      lastVal = curVal;
    }

    mySwitch.resetAvailable();
  }
}


void print_binary(unsigned long v, int num_places) // from http://www.phanderson.com/arduino/arduino_display.html
{
    unsigned long mask=0, n;
    for (n=1; n<=num_places; n++)
    {
        mask = (mask << 1) | 0x0001;
    }
    //v = v & mask;  // truncate v to specified number of places

    while(num_places)
    {

        if (v & ((unsigned long)1 << (num_places-1)))
        {
             Serial.print("1");
        }
        else
        {
             Serial.print("0");
        }

        --num_places;
        if(((num_places%4) == 0) && (num_places != 0))
        {
            Serial.print("_");
        }
    }
}


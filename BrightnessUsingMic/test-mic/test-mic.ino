#include <Adafruit_NeoPixel.h>
#define ledPIN 6
#define LED_COUNT 70

Adafruit_NeoPixel strip(LED_COUNT, ledPIN, NEO_GRB + NEO_KHZ800);
uint32_t purple = strip.Color(255,0,255);
uint32_t black = strip.Color(0,0,0);
//uint32_t red = strip.Color(100,0,100);


char val; // Data received from the serial port
int ledPin = 6;



void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT);
  strip.begin();
  strip.show();
  Serial.begin(9600);
  
}

void setAll(uint32_t c, int bright){
  for(uint16_t i=0; i<strip.numPixels(); i++) {
    strip.setPixelColor(i, c);
    strip.setBrightness(bright);
  }
  strip.show();

}

void loop() {
  // put your main code here, to run repeatedly:
//  if (Serial.available()) {
//     val = Serial.read(); // read it and store it in val
//   }

//   setAll(purple,val);
//   
//  if (val == '0') {
//     digitalWrite(ledPin, HIGH); // turn the LED on
//     setAll(purple);
//
//   }
  if (val > 0) {
     digitalWrite(ledPin, LOW); // otherwise turn it off
     setAll(purple, val);
//   }

//   if (val == '2') {
//     digitalWrite(ledPin, HIGH); // otherwise turn it off
//     setAll(red);
//   }
}
}
//declare setAll


//will receive only one state at a time
void serialEvent() {
  val = Serial.read();
}

//void clearAll() {
//  for(int i=0; i<ledStrip.numPixels(); i++) {
//  ledStrip.setPixelColor(i, 0);
//  }
//  ledStrip.show();
//}

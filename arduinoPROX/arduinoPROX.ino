#include <Adafruit_NeoPixel.h>
#define ledPIN 6
#define LED_COUNT 60

Adafruit_NeoPixel strip(LED_COUNT, ledPIN, NEO_GRB + NEO_KHZ800);
uint32_t blue = strip.Color(0,191,255);
uint32_t black = strip.Color(0,0,0);

char val; // Data received from the serial port
int ledPin = 13;

void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT);
  strip.begin();
  strip.show();
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
//  if (Serial.available()) {
//     val = Serial.read(); // read it and store it in val
//   }
  if (val == '0') {
     digitalWrite(ledPin, HIGH); // turn the LED on
     setAll(blue);
   }
  if (val == '1') {
     digitalWrite(ledPin, LOW); // otherwise turn it off
     setAll(black);
   }
}

//will receive only one state at a time
void serialEvent() {
  val = Serial.read();
}

//declare setAll
void setAll(uint32_t c){
  for(uint16_t i=0; i<strip.numPixels(); i++) {
    strip.setPixelColor(i, c);
  }
  strip.show();
}

//void clearAll() {
//  for(int i=0; i<ledStrip.numPixels(); i++) {
//  ledStrip.setPixelColor(i, 0);
//  }
//  ledStrip.show();
//}

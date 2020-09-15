#include <Adafruit_NeoPixel.h>
#define LED_PIN     6
#define NUM_LIGHTS  120

Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LIGHTS, LED_PIN, NEO_GRB + NEO_KHZ800);

void setup() {
  Serial.begin(57600);
  strip.begin();           
  strip.show();           
}

void loop() { 

 while (Serial.available()) {

        String first  = Serial.readStringUntil(',');
        Serial.read(); //next character is comma, so skip it using this
        String second = Serial.readStringUntil(',');
        Serial.read();
        String third  = Serial.readStringUntil(',');
        Serial.read();
        String fourth  = Serial.readStringUntil('\n');
        Serial.read();
        
        int r = first.toInt();
        int g = second.toInt();
        int b = third.toInt();
        int angle = fourth.toInt();
        
        uint32_t light = strip.Color(r, g, b);
        
        strip.setPixelColor(angle, light);
        strip.setBrightness(10);
        strip.show();       
    }
 }
 

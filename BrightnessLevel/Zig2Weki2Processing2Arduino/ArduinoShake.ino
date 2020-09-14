#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN            6

// How many NeoPixels are attached to the Arduino?
#define NUMPIXELS      60

// When we setup the NeoPixel library, we tell it how many pixels, and which pin to use to send signals.
// Note that for older NeoPixel strips you might need to change the third parameter--see the strandtest
// example for more information on possible values.
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

uint32_t Blue = pixels.Color(50,255,255);
uint32_t Aspar = pixels.Color(255,25,125);
uint32_t Erudite = pixels.Color(50,255,50);
uint32_t Mistyx = pixels.Color(175, 50, 255);
uint32_t Zaracrest = pixels.Color(255, 175, 50);
uint32_t Black = pixels.Color(0,0,0);
uint32_t White = pixels.Color(255,255,255);
uint32_t Purple = pixels.Color( 255, 40, 255 );
uint32_t Pink = pixels.Color( 255, 40, 130 );
uint32_t Red = pixels.Color(255, 40, 60);

int r;
int g;
int b;
//int head ;
byte buffer [4] ;
int receive;

void setup() {
  // put your setup code here, to run once:
  pixels.begin();
  //Serial.begin(115200);
  Serial.begin(9600);
  pixels.show();            // Turn OFF all pixels ASAP
  pixels.setBrightness(10);
}

void colorWipe(uint32_t color, int wait) {
  for(int i=0; i<pixels.numPixels(); i++) { // For each pixel in strip...
    pixels.setPixelColor(i, color);         //  Set pixel's color (in RAM)
    pixels.show();                          //  Update strip to match
    delay(wait);                           //  Pause for a moment
  }
}

void theaterChase(uint32_t color, int wait) {
  for(int a=0; a<20; a++) {  // Repeat 10 times...
    for(int b=0; b<3; b++) { //  'b' counts from 0 to 2...
      pixels.clear();         //   Set all pixels in RAM to 0 (off)
      // 'c' counts up from 'b' to end of strip in steps of 3...
      for(int c=b; c<pixels.numPixels(); c += 3) {
        pixels.setPixelColor(c, color); // Set pixel 'c' to value 'color'
      }
      pixels.show(); // Update strip with new contents
      delay(wait);  // Pause for a moment
    }
  }
}

void rainbow(int wait) {
  // Hue of first pixel runs 5 complete loops through the color wheel.
  // Color wheel has a range of 65536 but it's OK if we roll over, so
  // just count from 0 to 5*65536. Adding 256 to firstPixelHue each time
  // means we'll make 5*65536/256 = 1280 passes through this outer loop:
  for(long firstPixelHue = 0; firstPixelHue < 1*65536; firstPixelHue += 256) {
    for(int i=0; i<pixels.numPixels(); i++) { // For each pixel in strip...
      // Offset pixel hue by an amount to make one full revolution of the
      // color wheel (range of 65536) along the length of the strip
      // (strip.numPixels() steps):
      int pixelHue = firstPixelHue + (i * 65536L / pixels.numPixels());
      // strip.ColorHSV() can take 1 or 3 arguments: a hue (0 to 65535) or
      // optionally add saturation and value (brightness) (each 0 to 255).
      // Here we're using just the single-argument hue variant. The result
      // is passed through strip.gamma32() to provide 'truer' colors
      // before assigning to each pixel:
      pixels.setPixelColor(i, pixels.gamma32(pixels.ColorHSV(pixelHue)));
    }
    pixels.show(); // Update strip with new contents
    delay(wait);  // Pause for a moment
  }
}

void pattern1(){
//    colorWipe(Blue,50);
//    colorWipe(Aspar,50);
    colorWipe(Erudite,20);
    colorWipe(Mistyx,20);
//    colorWipe(Zaracrest,50);
}

void pattern2(){
  theaterChase(Blue,40);
//    theaterChase(Purple,50);
//    theaterChase(Pink,50);
//    theaterChase(Red, 50);
}

void pattern3(){
  rainbow(10);
}


void loop(){
// colorWipe(White,10);
 while (Serial.available()){
    receive = Serial.read();
}
  if (receive == 1){
     pattern1();
  }
  if (receive == 2){
      pattern2();
  }
  if (receive == 3){
      pattern3();
  }
}

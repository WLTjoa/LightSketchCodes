/**
 Sketch Simulate Leds and Mobile phone sensors.
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;
boolean lightsoff;
float angle ;
int r,g,b ;


void setup() {
  size(400,400);
  frameRate(25);
  //fullScreen();
  /* start oscP5, listening for incoming messages at port 65000 */
  oscP5 = new OscP5(this,50000);  //  <<<<<<<<<<<<Port number
  
  /* you must find your UUID and match it below */
  oscP5.plug(this, "grav", "/ZIGSIM/ms/gravity");  //  THEY MUST MATCH THE MESSAGE HEADER until your params
}

void grav( float x, float y , float z) {
      r = (int) map(y, -1.0, 1.0, 0, 255);
      g = (int) map(y, -1.0, 1.0, 0, 255);
      b = (int) map(y, -1.0, 1.0, 0, 255);
      println("Gravity : ", x, y, z);
}

void draw() {
  background( r,g,b) ;
}

void oscEvent(OscMessage theOscMessage) {
//  println("### received an osc message. with address pattern "+
//        theOscMessage.addrPattern()+" typetag "+ theOscMessage.typetag());
}

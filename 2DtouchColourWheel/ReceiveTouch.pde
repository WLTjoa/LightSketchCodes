/**
 Sketch Simulate Leds and Mobile phone sensors.
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;
boolean lightsoff;
float angle ;
int red ;
int r,g,b ;


void setup() {
  size(1000,1000);
  //fullScreen();
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 65000 */
  oscP5 = new OscP5(this,60000);  //  <<<<<<<<<<<<Port number
  
  myRemoteLocation = new NetAddress("10.27.125.161",60000);
  
  /* you must find your UUID and match it below */
  oscP5.plug(this, "t1", "/ZIGSIM/sylvia/touch0");  //  THEY MUST MATCH THE MESSAGE HEADER until your params
  oscP5.plug(this, "t2", "/ZIGSIM/sylvia/touch1");
    oscP5.plug(this, "t3", "/ZIGSIM/sylvia/touch2");
  
 
}

void t1( float x, float y ) {
  println("t1 : ", x, y);
   //if ((x>=0) && (y <=1));
      //r = (int) map(x, -1.0, 1.0, 125, 125);
      r = (int) map(y, -1.0, 1.0, 255, 0);
      b = (int) map(x, -1.0, 1.0, 255, 0);
      g = (int) map(x, -1.0, 1.0, 0, 255);
      g = (int) map(y, 0.0, 1.0, 0, 255);
      //g = (int) map(y, 0.0, 1.0, 0, 255);
     // println("Gravity : ", x, y);
}

//void t2( float x, float y ) {
//  println("t2 : ", x, y);
//      b = (int) map(x, -1.0, 1.0, 255, 0);
//      //b = (int) map(y, -1.0, 1.0, 0, 255);
//      g = (int) map(x, -1.0, 1.0, 0, 255);
//      //g = (int) map(y, -1.0, 1.0, 0, 255);
//}

//void t3( float x, float y ) {
//  println("t3 : ", x, y);
//      g = (int) map(x, -1.0, 1.0, 0, 255);
//      g = (int) map(y, -1.0, 1.0, 0, 255);
//}

void draw(){
  background (r,g,b);
  
}
//void oscEvent(OscMessage theOscMessage) {
//  println("### received an osc message. with address pattern "+
//        theOscMessage.addrPattern()+" typetag "+ theOscMessage.typetag());
//}

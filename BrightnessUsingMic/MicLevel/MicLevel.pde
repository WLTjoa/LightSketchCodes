/**
 Sketch Simulate Leds and Mobile phone sensors.
 */
 
import oscP5.*;
import netP5.*;

import processing.serial.*; // library imported

Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port
  
OscP5 oscP5;
NetAddress myRemoteLocation;
boolean lightsoff;
float angle ;
int r,g,b ;


void setup() {
  size(700,700);
  //fullScreen();
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 65000 */
  oscP5 = new OscP5(this,60000);  //  <<<<<<<<<<<<Port number
  
  //myRemoteLocation = new NetAddress("192.168.0.101",50000);
  
  /* you must find your UUID and match it below */
  oscP5.plug(this, "miclevel", "/ZIGSIM/sylvia/miclevel");  //  THEY MUST MATCH THE MESSAGE HEADER until your params
  //oscP5.plug(this, "quaternion", "/ZIGSIM/lpdemers/quaternion");
  
    
    String portName = Serial.list()[0];
    println(Serial.list());
    myPort = new Serial(this, "/dev/cu.usbmodem14101", 9600); /*remove for non arduino*/
}

void miclevel( float max, float average) {
      r = (int) map(max, -10.0, 0.0, 0, 100);
      //g = (int) map(max, -30.0, 0.0, 0, 255);
      //b = (int) map(max, -30.0, 0.0, 0, 255);
      println("MicLevel : ", max, average);
}

void miclevel(int x) {
      if (x <= -15.0){
      r = 0;
      g = 0;
      b = 0;
      myPort.write(r);
      }
}

//void quaternion( float x, float y , float z, float w) {
//      if ((x>=0.0) && (x <=0.3));
//      r = (int) map(x, 0.0, 0.3, 0, 255);
//      println("Gravity : ", x, y, z);
//}

//void draw() {
//  background( r,g,b) ;
//}

void draw() {
  background( r,g,b) ;
  myPort.write(255); /*remove for non arduino*/
  myPort.write(r);
  myPort.write(g);
  myPort.write(b); /*remove for non arduino*/
}

void oscEvent(OscMessage theOscMessage) {
//  println("### received an osc message. with address pattern "+
//        theOscMessage.addrPattern()+" typetag "+ theOscMessage.typetag());
}

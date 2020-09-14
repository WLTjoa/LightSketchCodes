/**
 Sketch Simulate Leds and Mobile phone sensors.
 */
 
import oscP5.*;
import netP5.*;

import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port
  
OscP5 oscP5;
NetAddress myRemoteLocation;
boolean lightsoff, shake;
float angle, xvalue, yvalue ;
int r,g,b;
int s = 0;

void setup() {
  size(400,400);
  frameRate(1);
  /* start oscP5, listening for incoming messages at port 65000 */
  oscP5 = new OscP5(this,50000);  //  <<<<<<<<<<<<Port number
  
  /* you must find your UUID and match it below */
  oscP5.plug(this, "accel", "/jinbebb/accel");  //  THEY MUST MATCH THE MESSAGE HEADER until your params
  //oscP5.plug(this, "quaternion", "/ZIGSIM/lpdemers/quaternion");
  
  String portName = Serial.list()[0];
  println(Serial.list());
  myPort = new Serial(this,portName, 9600);
}

void accel (float x, float y , float z) {
  if ((x > 8) || (x < -8)){
    shake = true;
    s = s + 1;
    println("shaketrue");
    println(s);
   }
}


void draw() { 
  background(255);
  text(s,50,50);
    if (s%3 == 0){
      myPort.write(1);
     //println("ahhhhhhh");
      shake = false;
    }
    if (s%3 == 1){
      myPort.write(2);
      shake = false;
    }
    if (s%3 == 2){
      myPort.write(3);
      shake = false;
    }
}


void oscEvent(OscMessage theOscMessage) {
//  println("### received an osc message. with address pattern "+
//        theOscMessage.addrPattern()+" typetag "+ theOscMessage.typetag());
}

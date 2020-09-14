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
boolean lightsoff;
float angle ;
int red ;


void setup() {
  size(400, 400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 65000 */
  oscP5 = new OscP5(this, 60000);  //  <<<<<<<<<<<<Port number

  /* you must find your UUID and match it below */
  //oscP5.plug(this, "quat", "/ZIGSIM/1/quaternion");  //  THEY MUST MATCH THE MESSAGE HEADER until your params
  oscP5.plug(this, "touch0", "/ZIGSIM/sylvia/touch0");
  oscP5.plug(this, "weki", "/wek/outputs"); // this is the raw data from weki
  oscP5.plug(this, "gest1", "/out1"); // by gestures (match triggers)
  oscP5.plug(this, "gest2", "/out2");
  oscP5.plug(this, "gest3", "/out3");

  myRemoteLocation = new NetAddress("localhost", 6448);

  //String portName = Serial.list()[0];
  //println(Serial.list());
    myPort = new Serial(this,"/dev/cu.usbmodem14101", 9600);
}

void touch0( float x, float y ) {
  OscMessage myMessage = new OscMessage("/wek/inputs");

  float x1 = map( x, -1.0, 1.0, 0.0, 1.0);  // wekinator takes value between 0.0 and 1.0
  float y1 = map( y, -1.2, 1.2, 0.0, 1.0);

  myMessage.add(x1); /* add an int to the osc message */
  myMessage.add(y1);

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 

  //println(x1,y1);
}
void weki (float out1, float out2, float out3) {
  //println(out1,out2,out3);
}

void gest1 () {
  println("G1");
  val=1;
  //myPort.write(1);
}
void gest2 () {
  println("G2");
  val = 2;
  //myPort.write(2);
}
void gest3 () {
  println("R");
  val =3;
  //myPort.write(3);
}

void draw() {
  if   (val == 1) {
    myPort.write(1);
  } else if (val ==2) {
    myPort.write(2);
  } else if (val == 3) {
    myPort.write(3);
  }
}



//void oscEvent(OscMessage theOscMessage) {
//  println("### received an osc message. with address pattern "+
//        theOscMessage.addrPattern()+" typetag "+ theOscMessage.typetag());
//}

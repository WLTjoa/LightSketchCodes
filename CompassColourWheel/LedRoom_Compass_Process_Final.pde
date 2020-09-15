import oscP5.*;
import netP5.*;
import processing.serial.*;
Serial port;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

boolean lightson;
int r,g,b,angle;
String inString;

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 65000 */
  oscP5 = new OscP5(this,50000);  //  <<<<<<<<<<<<Port number
  myRemoteLocation = new NetAddress ("192.168.1.14", 50000);
  
  //oscP5.plug(this, "touch", "/ZIGSIM/kjdaryl/touch0");
  //oscP5.plug(this, "force", "/ZIGSIM/kjdaryl/touchforce0");
  oscP5.plug(this, "compass", "/ZIGSIM/kjdaryl/compass");
  oscP5.plug(this, "quat", "/ZIGSIM/kjdaryl/quaternion");
  oscP5.plug(this, "grav", "/ZIGSIM/kjdaryl/gravity");
  
  port = new Serial(this, Serial.list()[2], 57600);
}

//void touch( float x, float y){
//      r = (int) map((float)y, -1.0, 1.0, 0, 255);
//      g = (int) map((float)x, -1.0, 1.0, 0, 255);
//      b = (int) map((float)x, -1.0, 1.0, 0, 255);
  
//  println (x,y);
  
//}

//void force( float z){
//  println (z);
//}

void compass( float p, int f){
  //println (p,f);
  
  angle = (int)map ((float)p , 0, 360, 0, 120);
  
 //r = (int)map ((float)p ,1, 100, 0, 255);
 //g = (int)map ((float)p ,1, 500, 0, 255);
 //b = (int)map ((float)p ,1, 10, 0, 255);
  
}

void quat (float w, float x, float y , float z){
//  println (a,b,c,d);
  
      r = (int) map((float)w, -1.0, 1.0, 0, 255);
      //g = (int) map((float)y, -1.0, 1.0, 0, 255);
     // b = (int) map((float)z, -1.0, 1.0, 0, 255);


}

void grav (float x, float y, float z) {
  //println (x,y,z);
  
      //r = (int) map((float)y, -1.0, 1.0, 100, 255);
      g = (int) map((float)y, -1.0, 1.0, 0, 255);
      b = (int) map((float)z, -1.0, 1.0, 0, 255);
     
}

void draw() {
   background(255);
   fill(r,g,b) ;
   rect(0,0,400,400);
   
   
  String colorMsg = r + "," + g + "," + b + "," + angle + "\n";
  println ("now sending color:" + colorMsg);
  port.write(colorMsg);
   
}


void serialEvent(Serial p) {
    inString = p.readString();
     println(inString);
}
 


//void oscEvent(OscMessage theOscMessage) {
//  println("### received an osc message. with address pattern "+
//        theOscMessage.addrPattern()+" typetag "+ theOscMessage.typetag());
//}

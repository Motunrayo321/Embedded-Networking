import processing.serial.*;

Serial port;
String result;


void setup() {
 size(360, 300);
 
 println(Serial.list());
 
 String portName = Serial.list()[0];
 
 port = new Serial (this, portName, 115200);
 port.bufferUntil('\n');
 
}


void serialEvent(Serial port) {
 String input = port.readStringUntil('\n');
 
 input = trim(input);
 result = "";
 
 //left, right, reset, serve = c.split(',');
 int sensors[] = int(split(input, ','));

 
 for (int sensor = 0; sensor < sensors.length; sensor++) {
  result += "Sensor " + sensor + ": " + sensors[sensor] + '\t'; 
  }
  println(result);
}


void draw() {
  background(#044f6f);
  fill(#ffffff);
  
  
  if (result != null) {
  text(result, 10, height/2);
  }
  
}

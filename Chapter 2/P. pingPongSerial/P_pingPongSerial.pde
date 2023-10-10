import processing.serial.*;

//float rightPaddle, leftPaddle;
int serve, reset;
int rightPaddleX, leftPaddleX;
float rightPaddleY, leftPaddleY;


int paddleHeight = 50;
int paddleWidth = 10;

Serial port;
String result;

float rightMin = 200;
float rightMax = 700;

float leftMin = 200;
float leftMax = 700;


void setup() {
 size(640, 480);
 
 println(Serial.list());
 
 String portName = Serial.list()[0];
 
 port = new Serial (this, portName, 115200);
 port.bufferUntil('\n');
 
 leftPaddleY = height/2;
 rightPaddleY = height/2;
 serve = 0;
 reset = 0;
 
 rightPaddleX = width - 50;
 leftPaddleX = 50;
 
}


void serialEvent(Serial port) {
 String input = port.readStringUntil('\n');
 
 input = trim(input);
 result = "";
 
 //left, right, reset, serve = c.split(',');
 int sensors[] = int(split(input, ','));
 
 if (sensors.length == 4) {
   leftPaddleY = map(sensors[0], leftMin, leftMax, 0, height);
   leftPaddleY = constrain(leftPaddleY, 0, height-50);
   
   rightPaddleY = map(sensors[1], rightMin, rightMax, 0, height);
   rightPaddleY = constrain(rightPaddleY, 0, height-50);

   serve = sensors[2];
   reset = sensors[3];
   
 }
 
 
 for (int sensor = 0; sensor < sensors.length; sensor++) {
  result += "Sensor " + sensor + ": " + sensors[sensor] + '\t'; 
  }
  println(result);
}


void draw() {
  background(#044f6f);
  fill(#ffffff);
  
  /*
  if (result != null) {
  text(result, 10, height/2);
  }
  */
  
  rect(rightPaddleX, rightPaddleY, paddleWidth, paddleHeight);
  
  rect(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight);

}

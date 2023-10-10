import processing.serial.*;

//Paddle Values
int serve, reset;
int rightPaddleX, leftPaddleX;
float rightPaddleY, leftPaddleY;

int paddleHeight = 50;
int paddleWidth = 10;

float rightMin = 200;
float rightMax = 700;

float leftMin = 200;
float leftMax = 700;


// Ball Values
int ballSize = 10;

int ballXDir = 1;
int ballYDir = 1;

int ballXPos, ballYPos;

boolean ballInMotion = false;


// Player Values
int player1 = 0;
int player2 = 0;

int fontSize = 36;


// Port Values
Serial port;
String result;


void setup() {
   // Creating window
   size(640, 480);
   
   // Initialising port
   println(Serial.list());
   
   String portName = Serial.list()[0];
   
   port = new Serial (this, portName, 115200);
   port.bufferUntil('\n');
   
   
   // Initialising Paddles
   leftPaddleY = height/2;
   rightPaddleY = height/2;
   serve = 0;
   reset = 0;
   
   rightPaddleX = width - 50;
   leftPaddleX = 50;
   
   noStroke();
   
   
   // Initialising ball
   ballXPos = width/2;
   ballYPos = height/2;
   
   
   // Initialising player scores
   PFont font = createFont(PFont.list()[2], fontSize);
   textFont(font);
 
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
  
  
  rect(rightPaddleX, rightPaddleY, paddleWidth, paddleHeight);
  
  rect(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight);

  if (ballInMotion == true) animateBall();
  if (serve == 1) ballInMotion = true;
  
  if (reset == 1) {
    ballInMotion = false;
    resetBall();
    
    player1 = 0;
    player2 = 0;
  }
  
  text (player1, fontSize, fontSize);
  text (player2, width-fontSize, fontSize);
}


void animateBall() {
  if (ballXDir < 0) {
    if (ballXPos <= leftPaddleX) {
      if ((leftPaddleY <= ballYPos)  && (ballYPos <= leftPaddleY + paddleHeight)) {
        
        ballXDir = -ballXDir;
      }
    }
  }
  
  else if (ballXDir > 0) {
    if (ballXPos >= rightPaddleX) {
      if ((rightPaddleY <= ballYPos) && (ballYPos <= rightPaddleY + paddleHeight)) {
        
        ballXDir = -ballXDir;
      }
    }
  }
  
  if (ballXPos < 0) {
    player2 ++;
    resetBall();
  }
  if (ballXPos > width) {
    player1 ++;
    resetBall();
  }
  
  if ((ballXPos - ballSize/2 <=0) || (ballXPos + ballSize/2 >= height)) ballYDir = -ballYDir;
  
  ballXPos = ballXPos + ballXDir;
  ballYPos = ballYPos + ballYDir;
  
  //println("LeftY: " + leftPaddleY);
  //println("LeftX: " + leftPaddleX);
  
  rect(ballXPos , ballYPos, ballSize, ballSize);
}


void resetBall() {
  ballXPos = width/2;
  ballYPos = height/2;
}

/*

Monski PONG
Processing window with paddles that respond to potientiometer readings sent from Serial
Serial data is sent from Arduino in Arduino code

Paddles function like tennis paddles
Multiplayer
Player scores saved

*/

import processing.serial.*;

//Paddle Values
int serve, reset;
int rightPaddleX, leftPaddleX;  // Horizontal {X} position
float rightPaddleY, leftPaddleY;  // Vertical {Y} position (determined by sensor)

int paddleHeight = 50;
int paddleWidth = 10;

float rightMin = 0;
float rightMax = 1024;

float leftMin = 0;
float leftMax = 1024;


// Ball Values
int ballSize = 10;

int ballXDir = 1;  // Initial direction - 1 pixel to the right {1 - right; -1 - left}
int ballYDir = 1;  // Initial direction - 1 pixel to the bottom {1 - bottom; -1 - top}

int ballXPos, ballYPos;

boolean ballInMotion = false;  // Initial movement of ball is false


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
   
   String portName = Serial.list()[0];  // Assign first port in list (usually Arduino)
   
   port = new Serial (this, portName, 115200);
   port.bufferUntil('\n');
   
   
   // Initialising Paddles
   leftPaddleY = height/2;  // Set left paddle to middle of height
   rightPaddleY = height/2;  // Set right paddle to middle of height
   serve = 0;
   reset = 0;
   
   rightPaddleX = width - 50;  // Set right paddle to 50 pixels from right
   leftPaddleX = 50;  // Set left paddle to 50 pixels from left
   
   noStroke();  // No border
   
   
   // Initialising ball
   ballXPos = width/2;  // Initial position is center
   ballYPos = height/2;
   
   
   // Initialising player scores
   PFont font = createFont(PFont.list()[2], fontSize);  // Create font for scores
   textFont(font);
 
}


void serialEvent(Serial port) {
 String input = port.readStringUntil('\n');  // Read characters in buffer
 
 input = trim(input);  // Remove carriage return and line feed
 result = "";  // Clear output string
 
 //left, right, reset, serve = c.split(',');
 int sensors[] = int(split(input, ','));  // Split comma separated values and add to list
 
 if (sensors.length == 4) {
   leftPaddleY = map(sensors[0], leftMin, leftMax, 0, height);  // Map and assign sensor values to paddle variable
   leftPaddleY = constrain(leftPaddleY, 0, height-50);  // Make sure paddle stays within window (otherwise, it goes out)
   
   rightPaddleY = map(sensors[1], rightMin, rightMax, 0, height);
   rightPaddleY = constrain(rightPaddleY, 0, height-50);

   serve = sensors[2];  // Assign sensor values
   reset = sensors[3];
   
 }
 
 
 for (int sensor = 0; sensor < sensors.length; sensor++) {
  result += "Sensor " + sensor + ": " + sensors[sensor] + '\t';  // Add sensor values to string to print out
  }
  println(result);  // Print sensor values in string
}


void draw() {
  background(#044f6f);  // Set background colour
  fill(#ffffff);  // Set text colours
  
  
  rect(rightPaddleX, rightPaddleY, paddleWidth, paddleHeight);  // Create right paddle rectangle
  
  rect(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight);  // Create left paddle rectangle


  if (ballInMotion == true) animateBall();  // Start ball movement
  if (serve == 1) ballInMotion = true;  // Set motion to true after serving ball
  
  if (reset == 1) {
    ballInMotion = false;  // After reset stop motion
    resetBall();  // Start ball from initial position (must serve to play again)
    
    player1 = 0;  // Clear player data
    player2 = 0;
  }
  
  text (player1, 20, fontSize);  // Set scores position and font
  text (player2, width-35, fontSize);
}


void animateBall() {
  if (ballXDir < 0) {  // If ball is moving to the left
    if (ballXPos <= (leftPaddleX + paddleWidth)) {  // If the ball isn't at the paddle yet
      if ((leftPaddleY <= ballYPos)  && (ballYPos <= leftPaddleY + paddleHeight)) {  // If the ball is within the height of paddle
        
        ballXDir = -ballXDir;  // Change ball X direction
      }
    }
  }
  
  else if (ballXDir > 0) {  // If ball is moving to the right (true after every serve)
    if (ballXPos >= (rightPaddleX - paddleWidth)) {  // If the ball isn't at the paddle yet
      if ((rightPaddleY <= ballYPos) && (ballYPos <= rightPaddleY + paddleHeight)) {  // If the ball is within the height of paddle
        
        ballXDir = -ballXDir;  // Change ball X direction
      }
    }
  }
  
  
  if (ballXPos < 0) {  // If ball is not still within window (has hit left wall)
    player2 ++;  // Increase opposite player's score {Right player}
    resetBall();  // Start ball from center again
  }
  
  if (ballXPos > width) {  // If ball is not still within window (has hit right wall)
    player1 ++;  // Increase opposite player's score {Left player}
    resetBall();  // Start ball from center again
  }
  
  
  // If ball has hit up or down (minus little margin {5 pixels}) change vertical direction
  if ((ballYPos - (ballSize/2) <=0) || (ballYPos + (ballSize) >= height)) ballYDir = -ballYDir;
  
  
  ballXPos = ballXPos + ballXDir;  // Update ball position by adding 1 pixel to left/right and top/bottom
  ballYPos = ballYPos + ballYDir;
  
  //println("LeftY: " + leftPaddleY);
  //println("LeftX: " + leftPaddleX);
  
  
  rect(ballXPos , ballYPos, ballSize, ballSize);  // Create ball with initial positions and size {X - Y}
}


void resetBall() {
  ballXPos = width/2;  // Place ball in window center
  ballYPos = height/2;
  
  ballXDir = 1;  // Initialise direction after reseting (*to randomise)
  ballYDir = 1;
}

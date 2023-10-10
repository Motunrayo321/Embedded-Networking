int right = A0;
int left = A1;

int RESET = 2;
int SERVE = 3;

int serveValue;
int resetValue;

int rightValue;
int leftValue;


void setup() {
  Serial.begin(115200);
}

void loop() {
  // Read sensor values
  serveValue = digitalRead(SERVE);
  resetValue = digitalRead(RESET);

  rightValue = analogRead(right);
  leftValue = analogRead(left);

/*
  Serial.print("Serve: ");   Serial.print(serveValue);   Serial.print("\t"); 
  Serial.print("Reset: ");   Serial.print(resetValue);   Serial.print("\t"); 

  Serial.print("Right: ");   Serial.print(rightValue);   Serial.print("\t"); 
  Serial.print("Left: ");   Serial.println(leftValue);
*/

  // Print comma-separated values to serial port
  Serial.print(rightValue); Serial.print(',');
  Serial.print(leftValue); Serial.print(',');
  Serial.print(serveValue); Serial.print(',');
  Serial.println(resetValue);


  delay(200);
}

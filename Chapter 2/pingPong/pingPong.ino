int rFlex = A0;
int lFlex = A1;

int RESET = 2;
int SERVE = 3;

int serveValue;
int resetValue;

int rFlexValue;
int lFlexValue;


void setup() {
  Serial.begin(115200);
}

void loop() {
  serveValue = digitalRead(SERVE);
  resetValue = digitalRead(RESET);

  rFlexValue = analogRead(rFlex);
  lFlexValue = analogRead(lFlex);

  Serial.print("Serve: ");   Serial.print(serveValue);   Serial.print("\t"); 
  Serial.print("Reset: ");   Serial.print(resetValue);   Serial.print("\t"); 

  Serial.print("Right: ");   Serial.print(rFlexValue);   Serial.print("\t"); 
  Serial.print("Left: ");   Serial.println(lFlexValue);


}

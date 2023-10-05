int led = 2;
int rLed = 3;

int flex = A0;
int val;

void setup() {
  // put your setup code here, to run once:

  Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:

  val = analogRead(flex);
  val = map(val, 0, 700, 0, 255);

  analogWrite(rLed, val);

  if (val > 200) digitalWrite(led, HIGH);
  else digitalWrite(led, LOW);
  
  Serial.println(val);
  delay(200);
}

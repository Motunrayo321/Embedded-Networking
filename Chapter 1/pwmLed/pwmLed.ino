int led = 3;

void setup() {
  // put your setup code here, to run once:
  pinMode(led, OUTPUT);

  Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
  for (int i=0; i <= 255; i = i + 50) {
    analogWrite(led, i);
    Serial.println(i);
    delay(2000);
  }
  
}

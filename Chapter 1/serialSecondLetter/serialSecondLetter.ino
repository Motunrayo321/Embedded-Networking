int LED = 13;
int inByte = 0;

int current = 0;
int interval = 4000;

void setup() {
  // put your setup code here, to run once:
  pinMode(LED, OUTPUT);
  Serial.begin(115200);

}

void loop() {
  // put your main code here, to run repeatedly:
  if (Serial.available() > 0) {
    inByte = Serial.read();

    Serial.println(inByte);
    Serial.write(inByte + 1);
  }

  if (millis() - current >= interval/2) {
    digitalWrite(LED, HIGH);
  }
  if (millis() - current >= interval) {
    digitalWrite(LED, LOW);
    current = millis();
  }
}

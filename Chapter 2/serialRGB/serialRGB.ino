int RED = 11;
int GREEN = 10;
int BLUE = 9;

int brightness;
int led;


void setup() {
  // put your setup code here, to run once:
  pinMode(RED, OUTPUT);
  pinMode(GREEN, OUTPUT);
  pinMode(BLUE, OUTPUT);

  Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
  if (Serial.available() > 0) {
    char c = Serial.read();

    Serial.print(c);

    if (c == 'r') led = RED;
    else if (c == 'g') led = GREEN;
    else if (c == 'b') led = BLUE;

    brightness = Serial.parseInt();
    brightness = map(brightness, 0, 9, 0, 255);
    brightness = constrain(brightness, 0, 255);

    analogWrite(led, brightness);

    // delay(200);
  }
}

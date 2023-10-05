const int RED = 18;
const int GREEN = 19;
const int BLUE = 21;

int c;
int current;
int brightness;


void setup() {
  // put your setup code here, to run once:
  pinMode(RED, OUTPUT);
  pinMode(GREEN, OUTPUT);
  pinMode(BLUE, OUTPUT);

  Serial.begin(115200);

}

void loop() {
  if (Serial.available() > 0) {
    c = Serial.read();

    if (c == 'r') {
      current = RED;
    }
    if (c == 'g') {
      current = GREEN;
    }
    if (c == 'b') {
      current = BLUE;
    }

    if (c >= 0 || c <=9) {
      brightness = map(c, 0, 9, 0, 255);
      analogWrite(current, brightness);
    }
  }
}

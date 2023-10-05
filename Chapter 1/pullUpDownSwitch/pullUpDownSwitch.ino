int BUT1 = 2;
int BUT2 = 4;

int val1;
int val2;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
  val1 = digitalRead(BUT1);
  val2 = digitalRead(BUT2);

  Serial.print("Button 1: "); Serial.print(val1); Serial.print("\t"); 
  Serial.print("Button 2: "); Serial.println(val2);

  delay (500);

}

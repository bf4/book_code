const unsigned int BUTTON_PIN = 7;
const unsigned int LED_PIN    = 13;

void setup() {
  pinMode(LED_PIN, OUTPUT);      
  pinMode(BUTTON_PIN, INPUT);     
}
void loop() {
  const int BUTTON_STATE = digitalRead(BUTTON_PIN);
  
  if (BUTTON_STATE == HIGH)
    digitalWrite(LED_PIN, HIGH);  
  else
    digitalWrite(LED_PIN, LOW); 
}


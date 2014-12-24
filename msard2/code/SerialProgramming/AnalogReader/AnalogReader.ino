const unsigned int BAUD_RATE = 9600;
const unsigned int NUM_PINS = 6;

String  pin_name = "";
boolean input_available = false;

void setup() { 
  Serial.begin(BAUD_RATE);
} 
 
void loop() {  
  if (input_available) {
    if (pin_name.length() > 1 &&
       (pin_name[0] == 'a' || pin_name[0] == 'A'))
    {
      const unsigned int pin = pin_name.substring(1).toInt();
      if (pin < NUM_PINS) {
        Serial.print(pin_name);
        Serial.print(": ");
        Serial.println(analogRead(pin));
      } else {
        Serial.print("Unknown pin: ");
        Serial.println(pin);
      }
    } else {
      Serial.print("Unknown pin name: ");
      Serial.println(pin_name);
    }
    pin_name = "";
    input_available = false;
  }
}

void serialEvent() {
  while (Serial.available()) {
    const char c = Serial.read();
    if (c == '\n')
      input_available = true;
    else
      pin_name += c;
  }
}


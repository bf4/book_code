const unsigned int PIR_INPUT_PIN = 2;
const unsigned int BAUD_RATE = 9600;

class PassiveInfraredSensor { 
  int _input_pin;
  
  public:
  PassiveInfraredSensor(const int input_pin) {
    _input_pin = input_pin;
    pinMode(_input_pin, INPUT);
  }
  const bool motion_detected() const {
    return digitalRead(_input_pin) == HIGH;
  }
};

PassiveInfraredSensor pir(PIR_INPUT_PIN);

void setup() {
  Serial.begin(BAUD_RATE);
}

void loop() {
  if (pir.motion_detected()) {
    Serial.println("Motion detected");
  } else {
    Serial.println("No motion detected");    
  }
  delay(200);
}


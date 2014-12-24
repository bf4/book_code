const unsigned int PING_SENSOR_IO_PIN = 7;
const unsigned int BAUD_RATE = 9600;

void setup() {
  Serial.begin(BAUD_RATE);
}

void loop() {
  pinMode(PING_SENSOR_IO_PIN, OUTPUT); 
  digitalWrite(PING_SENSOR_IO_PIN, LOW);
  delayMicroseconds(2); 

  digitalWrite(PING_SENSOR_IO_PIN, HIGH); 
  delayMicroseconds(5);
  digitalWrite(PING_SENSOR_IO_PIN, LOW); 

  pinMode(PING_SENSOR_IO_PIN, INPUT);
  const unsigned long duration = pulseIn(PING_SENSOR_IO_PIN, HIGH); 
  if (duration == 0) {
    Serial.println("Warning: We did not get a pulse from sensor.");
  } else {
    Serial.print("Distance to nearest object: ");
    Serial.print(microseconds_to_cm(duration));
    Serial.println(" cm");
  }
  
  delay(100);
}

unsigned long microseconds_to_cm(const unsigned long microseconds) {
  return microseconds / 29 / 2;
}

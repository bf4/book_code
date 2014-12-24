const unsigned int PING_SENSOR_IO_PIN = 7;
const unsigned int BAUD_RATE = 9600;
const float MICROSECONDS_PER_CM = 29.155;
const float MOUNTING_GAP = 0.2;
const float SENSOR_OFFSET = MOUNTING_GAP * MICROSECONDS_PER_CM * 2; 

void setup() {
  Serial.begin(BAUD_RATE);
}
void loop() {
  const unsigned long duration = measure_distance();
  if (duration == 0)
    Serial.println("Warning: We did not get a pulse from sensor.");
  else
    output_distance(duration);
}

const float microseconds_to_cm(const unsigned long microseconds) {
  const float net_distance = max(0, microseconds - SENSOR_OFFSET);
  return net_distance / MICROSECONDS_PER_CM / 2;
}

const unsigned long measure_distance() {
  pinMode(PING_SENSOR_IO_PIN, OUTPUT);
  digitalWrite(PING_SENSOR_IO_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(PING_SENSOR_IO_PIN, HIGH);
  delayMicroseconds(5);
  digitalWrite(PING_SENSOR_IO_PIN, LOW);
  pinMode(PING_SENSOR_IO_PIN, INPUT);
  return pulseIn(PING_SENSOR_IO_PIN, HIGH);
}

void output_distance(const unsigned long duration) {
  Serial.print("Distance to nearest object: ");
  Serial.print(microseconds_to_cm(duration)); 
  Serial.println(" cm");
}

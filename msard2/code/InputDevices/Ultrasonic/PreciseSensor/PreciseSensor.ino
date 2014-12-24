const unsigned int TEMP_SENSOR_PIN = A0;
const float SUPPLY_VOLTAGE = 5.0;
const unsigned int PING_SENSOR_IO_PIN = 7;
const float SENSOR_GAP = 0.2;
const unsigned int BAUD_RATE = 9600;
float current_temperature = 0.0;
unsigned long last_measurement = millis(); 

void setup() {
  Serial.begin(BAUD_RATE);
}
 
void loop() {
  unsigned long current_millis = millis(); 
  if (abs(current_millis - last_measurement) >= 1000) {
    current_temperature = get_temperature();
    last_measurement = current_millis;
  } 
  Serial.print(scaled_value(current_temperature));
  Serial.print(",");
  const unsigned long duration = measure_distance();
  Serial.println(scaled_value(microseconds_to_cm(duration)));
}

long scaled_value(const float value) {
  float round_offset = value < 0 ? -0.5 : 0.5;
  return (long)(value * 100 + round_offset);
}

const float get_temperature() {
  const int sensor_voltage = analogRead(TEMP_SENSOR_PIN);
  const float voltage = sensor_voltage * SUPPLY_VOLTAGE / 1024;
  return (voltage * 1000 - 500) / 10;
}

const float microseconds_per_cm() {
  return 1 / ((331.5 + (0.6 * current_temperature)) / 10000); 
}

const float sensor_offset() {
  return SENSOR_GAP * microseconds_per_cm() * 2;
}

const float microseconds_to_cm(const unsigned long microseconds) {
  const float net_distance = max(0, microseconds - sensor_offset());
  return net_distance / microseconds_per_cm() / 2;
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

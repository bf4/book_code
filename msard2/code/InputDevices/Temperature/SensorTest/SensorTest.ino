const unsigned int TEMP_SENSOR_PIN = A0;
const float SUPPLY_VOLTAGE = 5.0;
const unsigned int BAUD_RATE = 9600;

void setup() {
  Serial.begin(BAUD_RATE);
}
 
void loop() {
  const float tempC = get_temperature();
  const float tempF = (tempC * 9.0 / 5.0) + 32.0;
  Serial.print(tempC);
  Serial.print(" C, ");
  Serial.print(tempF);
  Serial.println(" F");
  delay(1000);
}

const float get_temperature() {
  const int sensor_voltage = analogRead(TEMP_SENSOR_PIN); 
  const float voltage = sensor_voltage * SUPPLY_VOLTAGE / 1024; 
  return (voltage * 1000 - 500) / 10; 
}


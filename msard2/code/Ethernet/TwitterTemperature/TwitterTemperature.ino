#define CELSIUS
const unsigned int TEMP_SENSOR_PIN = 0;
const unsigned int BAUD_RATE = 9600;
const float SUPPLY_VOLTAGE = 5.0; 
void setup() {
  Serial.begin(BAUD_RATE);
}
 
void loop() {
  const int sensor_voltage = analogRead(TEMP_SENSOR_PIN);
  const float voltage = sensor_voltage * SUPPLY_VOLTAGE / 1024;
  const float celsius = (voltage * 1000 - 500) / 10;
#ifdef CELSIUS
  Serial.print(celsius);
  Serial.println(" C");
#else
  Serial.print(9.0 / 5.0 * celsius + 32.0); 
  Serial.println(" F");
#endif
  delay(5000);
}


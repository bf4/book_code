#include <SPI.h>
#include <Ethernet.h>
#include "burglar_alarm.h"

const unsigned int PIR_INPUT_PIN = 2;
const unsigned int SMTP_PORT = 25;
const unsigned int BAUD_RATE = 9600;
const String       USERNAME  = "bm90bXl1c2VybmFtZQ=="; // Encoded in Base64.
const String       PASSWORD  = "bm90bXlwYXNzd29yZA=="; // Encoded in Base64.

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress my_ip(192, 168, 2, 120);

// Insert IP address of your SMTP server below!
IPAddress smtp_server(0, 0, 0, 0);
PassiveInfraredSensor pir_sensor(PIR_INPUT_PIN);
SmtpService           smtp_service(smtp_server, SMTP_PORT, USERNAME, PASSWORD);
BurglarAlarm          burglar_alarm(pir_sensor, smtp_service);

void setup() {
  Ethernet.begin(mac, my_ip);
  Serial.begin(BAUD_RATE);
  delay(20 * 1000);
}

void loop() {
  burglar_alarm.check();
  delay(3000);
}

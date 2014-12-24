#include <SPI.h>
#include <Ethernet.h>
#include "smtp_service.h"

const unsigned int SMTP_PORT = 2525;
const unsigned int BAUD_RATE = 9600;
const String       USERNAME  = "bm90bXl1c2VybmFtZQ=="; // Encoded in Base64.
const String       PASSWORD  = "bm90bXlwYXNzd29yZA=="; // Encoded in Base64.

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress my_ip(192, 168, 2, 120);

 // Insert IP address of your SMTP server below!
IPAddress smtp_server(0, 0, 0, 0);

SmtpService smtp_service(smtp_server, SMTP_PORT, USERNAME, PASSWORD);

void setup() {
  Ethernet.begin(mac, my_ip);
  Serial.begin(BAUD_RATE);
  delay(1000);
  Email email( 
    "arduino@example.com",
    "info@example.net",
    "Yet another subject",
    "Yet another body"
  );
  smtp_service.send_email(email);
}

void loop() {}


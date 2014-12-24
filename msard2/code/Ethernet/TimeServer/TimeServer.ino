#include <SPI.h>
#include <Ethernet.h>
const unsigned int BAUD_RATE = 9600;
const unsigned int DAYTIME_PORT = 13;

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress my_ip(192, 168, 2, 120);
IPAddress time_server(192, 43, 244, 18); // time.nist.gov
EthernetClient client; 

void setup() {
  Serial.begin(BAUD_RATE);
  Ethernet.begin(mac, my_ip); 
}

void loop() {
  delay(1000);
  Serial.print("Connecting...");
  
  if (client.connect(time_server, DAYTIME_PORT) <= 0) { 
    Serial.println("connection failed.");
  } else {
    Serial.println("connected.");
    delay(300);
    while (client.available()) {
      char c = client.read();
      Serial.print(c);
    }
    
    Serial.println("Disconnecting.");
    client.stop();
  }
}


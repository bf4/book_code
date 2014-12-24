#include <IRremote.h>

const unsigned int IR_RECEIVER_PIN = 11;
const unsigned int BAUD_RATE = 9600;

IRrecv ir_receiver(IR_RECEIVER_PIN);
decode_results results;

void setup() {
  Serial.begin(BAUD_RATE);
  ir_receiver.enableIRIn();
}

void dump(const decode_results* results) {
  const int protocol = results->decode_type; 
  Serial.print("Protocol: ");
  if (protocol == UNKNOWN) {
    Serial.println("not recognized.");
  } else  if (protocol == NEC) {
    Serial.println("NEC");
  } else if (protocol == SONY) {
    Serial.println("SONY");
  } else if (protocol == RC5) {
    Serial.println("RC5");
  } else if (protocol == RC6) {
    Serial.println("RC6");
  } else if (protocol == DISH) {
    Serial.println("DISH");
  } else if (protocol == SHARP) {
    Serial.println("SHARP");
  } else if (protocol == PANASONIC) {
    Serial.print("PANASONIC (");
    Serial.print("Address: ");
    Serial.print(results->panasonicAddress, HEX);
    Serial.println(")");
  } else if (protocol == JVC) {
    Serial.println("JVC");
  } else if (protocol == SANYO) {
    Serial.println("SANYO");
  } else if (protocol == MITSUBISHI) {
    Serial.println("MITSUBISHI");
  } else if (protocol == SAMSUNG) {
    Serial.println("SAMSUNG");
  } else if (protocol == LG) {
    Serial.println("LG");
  }
  Serial.print("Value: ");
  Serial.print(results->value, HEX);
  Serial.print(" (");
  Serial.print(results->bits, DEC);
  Serial.println(" bits)");
}

void loop() {
  if (ir_receiver.decode(&results)) {
    dump(&results);
    ir_receiver.resume();
  }
}


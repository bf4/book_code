#include <Wire.h>
#include "nunchuk.h"

const unsigned int BAUD_RATE = 19200;

Nunchuk nunchuk;

void setup() {
  Serial.begin(BAUD_RATE);
  nunchuk.initialize();
}

void loop() {
  if (nunchuk.update()) {
    Serial.print(nunchuk.joystick_x());
    Serial.print(" ");
    Serial.print(nunchuk.joystick_y());
    Serial.print(" ");
    Serial.print(nunchuk.x_acceleration());
    Serial.print(" ");
    Serial.print(nunchuk.y_acceleration());
    Serial.print(" ");
    Serial.print(nunchuk.z_acceleration());
    Serial.print(" ");
    Serial.print(nunchuk.z_button());
    Serial.print(" ");
    Serial.println(nunchuk.c_button());
  }
}


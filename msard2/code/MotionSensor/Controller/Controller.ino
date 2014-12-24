#include <Bounce2.h>
const unsigned int BUTTON_PIN = 7;
const unsigned int X_AXIS_PIN = A2;
const unsigned int Y_AXIS_PIN = A1;
const unsigned int Z_AXIS_PIN = A0;
const unsigned int NUM_AXES = 3;
const unsigned int PINS[NUM_AXES] = { 
  X_AXIS_PIN, Y_AXIS_PIN, Z_AXIS_PIN 
};
const unsigned int BUFFER_SIZE = 16;
const unsigned int BAUD_RATE = 38400;
int buffer[NUM_AXES][BUFFER_SIZE];
int buffer_pos[NUM_AXES] = { 0 };
boolean button_pressed = false;

Bounce button;

void setup() {
  Serial.begin(BAUD_RATE);
  pinMode(BUTTON_PIN, INPUT);
  button.attach(BUTTON_PIN);
  button.interval(20);
}

int get_axis(const int axis) {
  delay(1);
  buffer[axis][buffer_pos[axis]] = analogRead(PINS[axis]);
  buffer_pos[axis] = (buffer_pos[axis] + 1) % BUFFER_SIZE;

  long sum = 0;
  for (unsigned int i = 0; i < BUFFER_SIZE; i++)
    sum += buffer[axis][i];
  return round(sum / BUFFER_SIZE);
}
int get_x() { return get_axis(0); }
int get_y() { return get_axis(1); }
int get_z() { return get_axis(2); }

void loop() {
  Serial.print(get_x());
  Serial.print(" ");
  Serial.print(get_y());
  Serial.print(" ");
  Serial.print(get_z());
  Serial.print(" ");
  if (button.update()) {
    button_pressed = button.read() == HIGH;
  }
  Serial.println(button_pressed == HIGH ? "1" : "0");
  delay(10);
}

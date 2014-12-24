#include <TVout.h>
#include <fontALL.h>
#include "thermometer.h"

const float SUPPLY_VOLTAGE = 5.0;
const float MIN_TEMP = 5.5;
const float MAX_TEMP = 40.0;
const unsigned int SCREEN_WIDTH = 120;
const unsigned int SCREEN_HEIGHT = 96;
const unsigned int TEMP_SENSOR_PIN = A0;
const unsigned int SCALE_X_MIN = 8;
const unsigned int SCALE_Y_MIN = 6;
const unsigned int SCALE_Y_MAX = 75;
const unsigned int SCALE_WIDTH = 3;
const unsigned int SCALE_HEIGHT = SCALE_Y_MAX - SCALE_Y_MIN;

float current_temperature = 0.0;
unsigned long last_measurement = millis();
TVout TV;

void setup() {
  TV.begin(PAL, SCREEN_WIDTH, SCREEN_HEIGHT);
  TV.bitmap(0, 1, thermometer);
  TV.select_font(font4x6);
  TV.set_cursor(20, 4);
  TV.print("40");
  TV.set_cursor(20, 24);
  TV.print("30");
  TV.set_cursor(20, 44);
  TV.print("20");
  TV.set_cursor(20, 64);
  TV.print("10");
}

void loop() {
  unsigned long current_millis = millis();
  if (abs(current_millis - last_measurement) >= 1000) {
    current_temperature = get_temperature();
    last_measurement = current_millis;
    int y_pos = mapfloat( 
      current_temperature, MIN_TEMP, MAX_TEMP, SCALE_Y_MAX, SCALE_Y_MIN);
    TV.draw_rect(
      SCALE_X_MIN, SCALE_Y_MIN, SCALE_WIDTH, SCALE_HEIGHT, BLACK, BLACK);
    TV.draw_rect(
      SCALE_X_MIN, y_pos, SCALE_WIDTH, SCALE_Y_MAX - y_pos, WHITE, WHITE);
    TV.select_font(font6x8);
    TV.set_cursor(53, 1);
    TV.print("Current");
    TV.set_cursor(40, 11);
    TV.print("Temperature:");
    TV.select_font(font8x8);
    TV.set_cursor(50, 25);
    TV.print(current_temperature, 1);
    TV.print(" C");
    TV.draw_circle(88, 27, 1, WHITE); 
   }
}

const float mapfloat(
  float x, float in_min, float in_max, float out_min, float out_max)
{
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

const float get_temperature() {
  const int sensor_voltage = analogRead(TEMP_SENSOR_PIN);
  const float voltage = sensor_voltage * SUPPLY_VOLTAGE / 1024;
  return (voltage * 1000 - 500) / 10;
}


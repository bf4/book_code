/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
#ifndef __PIR_SENSOR__H__
#define __PIR_SENSOR__H__

#include <Arduino.h>

class PassiveInfraredSensor {
  int _input_pin;

  public:

  PassiveInfraredSensor(const int input_pin) {
    _input_pin = input_pin;
    pinMode(_input_pin, INPUT);
  }
  
  const bool motion_detected() const {
    return digitalRead(_input_pin) == HIGH;
  }
};

#endif

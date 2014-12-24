/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
#ifndef __NUNCHUK_H__
#define __NUNCHUK_H__
#define NUNCHUK_BUFFER_SIZE 6 

class Nunchuk {
public:
  void initialize();
  bool update();
  
  int joystick_x() const { return _buffer[0]; }
  int joystick_y() const { return _buffer[1]; }

  int x_acceleration() const {
    return ((int)(_buffer[2]) << 2) | ((_buffer[5] >> 2) & 0x03);
  }
  
  int y_acceleration() const {
    return ((int)(_buffer[3]) << 2) | ((_buffer[5] >> 4) & 0x03);
  }
  
  int z_acceleration() const {
    return ((int)(_buffer[4]) << 2) | ((_buffer[5] >> 6) & 0x03);
  }
  bool z_button() const { return !(_buffer[5] & 0x01); }
  bool c_button() const { return !(_buffer[5] & 0x02); }
  
private:
  void request_data();
  char decode_byte(const char);
  
  unsigned char _buffer[NUNCHUK_BUFFER_SIZE]; 
};

#endif


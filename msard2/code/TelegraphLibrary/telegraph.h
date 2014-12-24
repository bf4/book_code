/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
#ifndef __TELEGRAPH_H__
#define __TELEGRAPH_H__

class Telegraph {
public:
  Telegraph(const int output_pin, const int dit_length);
  void send_message(const char* message);
  
private:
  void dit();
  void dah();
  void output_code(const char* code);
  void output_symbol(const int length);
  
  int _output_pin;
  int _dit_length;
  int _dah_length;
};

#endif


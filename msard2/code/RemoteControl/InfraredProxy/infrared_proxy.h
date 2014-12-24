/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
#ifndef __IRPROXY__
#define __IRPROXY__
#include <SPI.h>
#include <Ethernet.h>
#include <IRremote.h>

class InfraredProxy {
  private:
  IRsend _infrared_sender;

  void read_line(EthernetClient& client, char* buffer, const int buffer_length);
  bool send_ir_data(const char* protocol, const int bits, const long value);
  bool handle_command(char* line);
  
  public:
  void receive_from_server(EthernetServer server);
};
#endif


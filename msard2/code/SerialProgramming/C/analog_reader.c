/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include "arduino-serial-lib.h"
#define MAX_LINE 256

int main(int argc, char* argv[]) {
  int timeout = 1000;

  if (argc == 1) {
    printf("You have to pass the name of a serial port.\n");
    return -1;
  }
  int baudrate = B9600;
  int arduino = serialport_init(argv[1], baudrate); 
  if (arduino == -1) {
    printf("Could not open serial port %s.\n", argv[1]);
    return -1;
  }
  sleep(2);
  char line[MAX_LINE];
  while (1) {
    int rc = serialport_write(arduino, "a0\n"); 
    if (rc == -1) {
      printf("Could not write to serial port.\n");
    } else {
      serialport_read_until(arduino, line, '\n', MAX_LINE, timeout); 
      printf("%s", line);
    }
  }
  serialport_close(arduino);
  return 0;
}

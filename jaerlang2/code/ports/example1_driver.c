/***
 * Excerpted from "Programming Erlang, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
***/
#include <stdio.h>
#include <stdlib.h>
typedef unsigned char byte;

int read_cmd(byte *buff);
int write_cmd(byte *buff, int len);
int sum(int x, int y);
int twice(int x);

int main() {
  int fn, arg1, arg2, result;
  byte buff[100];

  while (read_cmd(buff) > 0) {
    fn = buff[0];
	
    if (fn == 1) {
      arg1 = buff[1];
      arg2 = buff[2];
	  
      /* debug -- you can print to stderr to debug
	 fprintf(stderr,"calling sum %i %i\n",arg1,arg2); */
      result = sum(arg1, arg2);
    } else if (fn == 2) {
      arg1 = buff[1];
      result = twice(arg1);
    } else {
      /* just exit on unknown function */
      exit(EXIT_FAILURE);
    }
    buff[0] = result;
    write_cmd(buff, 1);
  }
}

/***
 * Excerpted from "Programming Ruby 1.9 and 2.0",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
***/
#include <stdlib.h>
#include "cdjukebox.h"

CDJukebox *new_jukebox() {
  CDJukebox *jb = (CDJukebox *)malloc(sizeof(CDJukebox));
  jb->pending = 'P';
  return jb;
}

void assign_jukebox(CDJukebox *jb, int unit_id) {
  jb->unit_id = unit_id;
}

void free_jukebox(CDJukebox *jb) {
  free(jb);
}

void jukebox_seek(CDJukebox *jb, 
		  int disc, 
		  int track,
		  void (*done)(CDJukebox *jb, int percent)) {
  done(jb, 26);
  done(jb, 79);
  done(jb, 100);
}


double get_avg_seek_time(CDJukebox *jb) {
  return 1.2;
}

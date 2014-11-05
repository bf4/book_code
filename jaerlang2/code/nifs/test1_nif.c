/***
 * Excerpted from "Programming Erlang, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
***/
/* test1_nif.c */

#include "erl_nif.h"
#include <stdio.h> 

static ERL_NIF_TERM c_addem(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
  int x, y, ret;
  enif_get_int(env, argv[0], &x);
  enif_get_int(env, argv[1], &y);
  ret = 3 * x + y;
  return enif_make_int(env, ret);
}

static ErlNifFunc nif_funcs[] =
{
  {"addem", 2, c_addem},
};


ERL_NIF_INIT(test1_nif,nif_funcs,NULL,NULL,NULL,NULL)

/***
 * Excerpted from "Programming Erlang, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
***/
/* niftest.c */
#include <stdio.h>
#include "erl_nif.h"

/* http://www.startinchina.com/programming/erlang/erlang_nif_tutorial.html*/

static ERL_NIF_TERM triple(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
  int x;
  if (!enif_get_int(env, argv[0], &x)) //needs to be an integer 
  { 
    return enif_make_badarg(env); 
  }
  fprintf(stderr, "Value of argv[0]: %d\n", x);
  return enif_make_int(env, 3*x);
}

static ErlNifFunc nif_funcs[] =
{
  {"triple", 1, triple}
};

ERL_NIF_INIT(nif_test2,nif_funcs,NULL,NULL,NULL,NULL)

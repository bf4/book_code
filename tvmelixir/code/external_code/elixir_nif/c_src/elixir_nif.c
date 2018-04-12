/***
 * Excerpted from "Adopting Elixir",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tvmelixir for more book information.
***/
#include "string.h"
#include "erl_nif.h"

static ERL_NIF_TERM hello(ErlNifEnv* env,
                          int argc,
                          const ERL_NIF_TERM argv[]) {
  ErlNifBinary *output_binary;
  enif_alloc_binary(sizeof "Hello from C", output_binary);
  strcpy(output_binary->data, "Hello from C");
  return enif_make_binary(env, output_binary);
}

static ErlNifFunc nif_funcs[] = {
    {"hello", 0, hello},
};

ERL_NIF_INIT(Elixir.ElixirNif, nif_funcs, NULL, NULL, NULL, NULL)

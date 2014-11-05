/***
 * Excerpted from "Programming Erlang, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
***/
/* darray.c -- destructive array of intgers */

#include "erl_nif.h"

#include <stdio.h> 
#include <stddef.h> /* offsetof */

typedef struct {
  int len;
  int *data;
} State;

ERL_NIF_TERM enif_make_handle(ErlNifEnv* env, void* obj);

static ErlNifResourceType* my_array_type = NULL;

static ERL_NIF_TERM make_array(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
  ERL_NIF_TERM handle;
   
  int i,x;
  State* state;
  if (!enif_get_int(env, argv[0], &x)) return enif_make_badarg(env); 
  state = (State*)enif_alloc_resource(my_array_type, sizeof(State));
  state->data = malloc(x*sizeof(int));
  state->len  = x;
  for(i=0;i<x;i++)
    state->data[i] = i;

  handle = enif_make_handle(env, state);
  return handle;
}

static ERL_NIF_TERM get_element(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
  State *state;
  int i, j;
  if (!enif_get_int(env, argv[1], &i))return enif_make_badarg(env); 
  if (!enif_get_resource(env, argv[0], my_array_type, (void **)&state))
      return enif_make_badarg(env); 
  j = state->data[i];
  return enif_make_int(env, j);
}


static ERL_NIF_TERM set_element(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
  State *state;
  int i, j;
  if (!enif_get_int(env, argv[1], &i)) return enif_make_badarg(env); 
  if (!enif_get_int(env, argv[2], &j)) return enif_make_badarg(env); 
  if (!enif_get_resource(env, argv[0], my_array_type, (void **)&state))
    return enif_make_badarg(env); 
  if(i < 1 || i > state->len){
    return enif_make_badarg(env);
  };
  state->data[i]=j;
  return enif_make_atom(env, "true");
}

static ErlNifFunc nif_funcs[] =
{
  {"make_array", 1, make_array},
  {"set_element", 3, set_element},
  {"get_element", 2, get_element}
};

static void destroy_my_array_type_resource(ErlNifEnv* env, void* obj)
{
  State* state = (State*)obj;
  free(state->data); 
  fprintf(stderr, "destroying resource length=%i\r\n", state->len);
}

int load(ErlNifEnv* env, void** priv_data, ERL_NIF_TERM load_info)
  {
    my_array_type = enif_open_resource_type(env, NULL, "my_resource1",
					    destroy_my_array_type_resource,
					    ERL_NIF_RT_CREATE,
					    NULL);
    return 0;
  }

ERL_NIF_INIT(darray,nif_funcs,load,NULL,NULL,NULL)

ERL_NIF_TERM enif_make_handle(ErlNifEnv* env, void* obj)
{
  ERL_NIF_TERM handle;
  handle = enif_make_resource(env, obj);
  enif_release_resource(obj);     
  return handle;
}


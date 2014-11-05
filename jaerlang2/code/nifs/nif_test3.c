/***
 * Excerpted from "Programming Erlang, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
***/
/* niftest.c */
#include "erl_nif.h"
#include <stdio.h> 

static ErlNifResourceType* myarray = NULL;

static ERL_NIF_TERM alloc(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
  ERL_NIF_TERM term;
   
  int i,x;
  int *a;
  if (!enif_get_int(env, argv[0], &x)) //needs to be an integer 
  { 
    return enif_make_badarg(env); 
  }
  /* allocate space for x integers */
  
  a = enif_alloc_resource(myarray, x*sizeof(int));
  for(i=0;i<x;i++)
    a[i] = i;
  term = enif_make_resource(env, a);
  enif_release_resource(a);         /* must have this for the reference counter
					       since alloc_resource bumps the ref counter */
  return term;
}

static ERL_NIF_TERM get(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
  int *a;
  int i, j;
  if (!enif_get_int(env, argv[1], &i)) //needs to be an integer 
    { 
      return enif_make_badarg(env); 
    }
  if (!enif_get_resource(env, argv[0], myarray, (void **) &a))
    {
      return enif_make_badarg(env); 
    }
  j = a[i];
  return enif_make_int(env, j);
}


static ERL_NIF_TERM set(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
  int *a;
  int i, j;

  if (!enif_get_int(env, argv[1], &i)) //needs to be an integer 
    { 
      return enif_make_badarg(env); 
    };
  fprintf(stderr, "i: %d\n", i);
  if (!enif_get_int(env, argv[2], &j)) //needs to be an integer 
    { 
      return enif_make_badarg(env); 
    };
  fprintf(stderr, "j: %d\n", j);

  fprintf(stderr, "myarray: %p\n", myarray);


  if (!enif_get_resource(env, argv[0], myarray, (void **)&a))
    {
      return enif_make_badarg(env); 
    }
  a[i]=j;
  return enif_make_atom(env, "true");
}


static ErlNifFunc nif_funcs[] =
{
  {"alloc", 1, alloc},
  {"set", 3, set},
  {"get", 2, get}
};

int load(ErlNifEnv* env, void** priv_data, ERL_NIF_TERM load_info)
  {
    myarray = enif_open_resource_type(env, NULL, "joesresource",
				      NULL,ERL_NIF_RT_CREATE,
				      NULL);
    fprintf(stderr, "myarray: %p\n", myarray);
    return 0;
  }

ERL_NIF_INIT(nif_test3,nif_funcs,load,NULL,NULL,NULL)

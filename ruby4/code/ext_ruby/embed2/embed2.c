/***
 * Excerpted from "Programming Ruby 1.9 and 2.0",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
***/
#include "ruby.h"

static int id_sum;

int Values[] = { 5, 10, 15, -1, 20, 0 };

static VALUE wrap_sum(VALUE args) {
  VALUE *values = (VALUE *)args;
  VALUE  summer = values[0];
  VALUE  max    = values[1];
  return rb_funcall(summer, id_sum, 1, max);
}

static VALUE protected_sum(VALUE summer, VALUE max) {
  int error;
  VALUE args[2];
  VALUE result;

  args[0] = summer;
  args[1] = max;
  result = rb_protect(wrap_sum, (VALUE)args, &error);

  return error ? Qnil : result;
}

int main(int argc, char **argv) {
  int value;
  int *next = Values;
  int error;

  ruby_sysinit(&argc, &argv);
  RUBY_INIT_STACK;
  ruby_init();
  ruby_init_loadpath();
  ruby_script("demo_embedder");  /* sets name in error messages */

  rb_protect((VALUE (*)(VALUE))rb_require, (VALUE)"sum", &error);

  // get an instance of Summer
  VALUE summer = rb_class_new_instance(0, 0, 
                     rb_const_get(rb_cObject, rb_intern("Summer")));

  id_sum = rb_intern("sum");

  while (value = *next++) {
    VALUE  result = protected_sum(summer, INT2NUM(value));
    if (NIL_P(result))
      printf("Sum to %d doesn't compute!\n", value);
    else
      printf("Sum to %d is %d\n", value, NUM2INT(result));
  }

  return ruby_cleanup(0);
}

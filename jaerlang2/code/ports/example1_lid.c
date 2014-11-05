/***
 * Excerpted from "Programming Erlang, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
***/
/* example1_lid.c */

#include <stdio.h>
#include "erl_driver.h"

typedef struct {
    ErlDrvPort port;
} example_data;

static ErlDrvData example_drv_start(ErlDrvPort port, char *buff)
{
    example_data* d = (example_data*)driver_alloc(sizeof(example_data));
    d->port = port;
    return (ErlDrvData)d;
}

static void example_drv_stop(ErlDrvData handle)
{
    driver_free((char*)handle);
}

static void example_drv_output(ErlDrvData handle, char *buff, 
			       ErlDrvSizeT bufflen)
{
    example_data* d = (example_data*)handle;
    char fn = buff[0], arg = buff[1], res;
    if (fn == 1) {
      res = twice(arg);
    } else if (fn == 2) {
      res = sum(buff[1], buff[2]);
    }
    driver_output(d->port, &res, 1);
}

static ErlDrvEntry example_driver_entry = {
    NULL,               /* F_PTR init, N/A */
    example_drv_start,  /* L_PTR start, called when port is opened */
    example_drv_stop,   /* F_PTR stop, called when port is closed */
    example_drv_output, /* F_PTR output, called when erlang has sent
			   data to the port */
    NULL,               /* F_PTR ready_input, 
                           called when input descriptor ready to read*/
    NULL,               /* F_PTR ready_output, 
                           called when output descriptor ready to write */
    "example1_drv",     /* char *driver_name, the argument to open_port */
    NULL,               /* F_PTR finish, called when unloaded */
    NULL,               /* F_PTR control, port_command callback */
    NULL,               /* F_PTR timeout, reserved */
    NULL,               /* F_PTR outputv, reserved */
    NULL,               /* process, */
    NULL,                             /* ready_async */
    NULL,                             /* flush */
    NULL,                             /* call */
    NULL,                             /* event */
    ERL_DRV_EXTENDED_MARKER,          /* ERL_DRV_EXTENDED_MARKER */
    ERL_DRV_EXTENDED_MAJOR_VERSION,   /* ERL_DRV_EXTENDED_MAJOR_VERSION */
    ERL_DRV_EXTENDED_MINOR_VERSION,   /* ERL_DRV_EXTENDED_MINOR_VERSION */
    ERL_DRV_FLAG_USE_PORT_LOCKING,     /* ERL_DRV_FLAGs */
    NULL,
    NULL
};

DRIVER_INIT(example_drv) /* must match name in driver_entry */
{
    return &example_driver_entry;
}


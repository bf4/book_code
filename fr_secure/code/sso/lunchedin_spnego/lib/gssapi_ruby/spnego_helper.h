#include <gssapi.h>
#include <stdio.h>
#include <gssapi/gssapi_generic.h>
#include <string.h>



#include "spnego/spnego.h"
#include "spnego/spnegoparse.h"
#include "spnego/derparse.h"

// #include "spnego/spnegodata.h"




const char * getTokenAsSPNEGO(gss_buffer_t IN);
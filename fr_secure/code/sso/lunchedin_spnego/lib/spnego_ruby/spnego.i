%module R_spnego

%apply char *INPUT { unsigned char *pbMechToken };

%include "../../../spnegotokenhandler/src/spnego.h"

%{

#include "../../../spnegotokenhandler/src/spnego.h"
#include "../../../spnegotokenhandler/src/spnegodata.h"
#include "../../../spnegotokenhandler/src/derparse.h"
#include "../../../spnegotokenhandler/src/spnegoparse.h"

%}


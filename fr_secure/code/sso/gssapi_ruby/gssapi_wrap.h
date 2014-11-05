#include <gssapi.h>
#include <stdio.h>
#include <gssapi/gssapi_generic.h>
#include <string.h>

typedef struct gssapi_data {
  gss_name_t      gss_name; //opaque type
  gss_cred_id_t   credentials;  //opaque type
  OM_uint32       major_status; //basic unsigned int
  OM_uint32       minor_status; //basic unsigned int
  gss_ctx_id_t    ctx;          //opaque type
  gss_buffer_desc recvToken;    //value / length buffer
  gss_buffer_desc sendToken;    //value / length buffer
} GSSAPI_RESULT;

const char * getMechErrorMessage(OM_uint32 iMinorStatus);
const char *  getGssErrorMessage(OM_uint32 iMajorStatus);
int GssImportNameHelper(const char * serviceName);
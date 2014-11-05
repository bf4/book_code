#include "spnego_helper.h"


// const char * getGssErrorMessage(OM_uint32 iMajorStatus) {
// 	OM_uint32 message_context = 0;
// 	gss_buffer_desc status_string;
// 	OM_uint32 tempStatus = 0;
// 	printf("\nAttempting to display error message::\n");
// 	gss_display_status( &tempStatus, iMajorStatus, GSS_C_GSS_CODE, GSS_C_NULL_OID, &message_context, &status_string );
// 	printf("\nprinting GSS status:\n %s\n", status_string.value);
// 	return status_string.value;
// }

const char * getTokenAsSPNEGO(unsigned char * IN) {
	return "";
}
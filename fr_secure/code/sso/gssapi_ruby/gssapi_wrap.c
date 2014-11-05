#include "gssapi_wrap.h"

const gss_OID NT_USER_NAME() {
  return GSS_C_NT_USER_NAME;
};

const gss_OID NT_MACHINE_UID_NAME() {
  return GSS_C_NT_MACHINE_UID_NAME;
};

const gss_OID NT_STRING_UID_NAME() {
  return GSS_C_NT_STRING_UID_NAME;
};

const gss_OID NT_HOSTBASED_SERVICE() {
  return GSS_C_NT_HOSTBASED_SERVICE;
};

const gss_OID NT_ANONYMOUS() {
  return GSS_C_NT_ANONYMOUS;
};

const gss_OID NT_EXPORT_NAME() {
  return GSS_C_NT_EXPORT_NAME;
};

const gss_OID_set NULL_OID_SET() {
  return GSS_C_NULL_OID_SET;
}

const char * getGssErrorMessage(OM_uint32 iMajorStatus) {
  OM_uint32 message_context = 0;
  gss_buffer_desc status_string;
  OM_uint32 tempStatus = 0;
  printf("\nAttempting to display error message::\n");
  gss_display_status( &tempStatus, iMajorStatus, 
                      GSS_C_GSS_CODE, GSS_C_NULL_OID, 
                      &message_context, &status_string );
                      
  printf("\nprinting GSS status:\n %s\n", status_string.value);
  return status_string.value;
}

const char * getMechErrorMessage(OM_uint32 iMinorStatus) {
  OM_uint32 message_context = 0;
  gss_buffer_desc status_string;
  OM_uint32 tempStatus = 0;
  printf("\nAttempting to display error message::\n");
  gss_display_status( &tempStatus, iMinorStatus, 
                      GSS_C_MECH_CODE, GSS_C_NULL_OID, 
                      &message_context, &status_string );
                      
  printf("\nprinting MECH status:\n %s\n", status_string.value);
  return "";
}
// START:printErrors
void printErrors(OM_uint32 iMajorStatus, OM_uint32 iMinorStatus) {
  OM_uint32 message_context = 0;
  gss_buffer_desc status_string;
  
  OM_uint32 tempStatus = 0;
  gss_display_status( &tempStatus, iMajorStatus, 
                      GSS_C_GSS_CODE, GSS_C_NULL_OID, 
                      &message_context, &status_string );
  printf("GSS status: %s\n", status_string.value);
  
  gss_display_status( &tempStatus, iMinorStatus, 
                      GSS_C_MECH_CODE, GSS_C_NULL_OID, 
                      &message_context, &status_string );
                      
  printf("MECH status: %s\n", status_string.value);
  
  return;
}
// END:printErrors

int GssImportNameHelper(const char * serviceName) {
  OM_uint32 iMajorStatus;
  OM_uint32 iMinorStatus;
  gss_buffer_desc stServerNameBuffer;
  gss_name_t stServerName;
  
  int len = strlen(serviceName) + 1;
  stServerNameBuffer.value = (char *)serviceName;
  stServerNameBuffer.length = len;
  
  iMajorStatus = gss_import_name( 
    &iMinorStatus,
    &stServerNameBuffer, 
    GSS_C_NT_USER_NAME, 
    &stServerName );
  
  if( iMajorStatus != GSS_S_COMPLETE ) {
    printf("Error importing.");
    OM_uint32 message_context = 0;
    gss_buffer_desc status_string;
    
    OM_uint32 tempStatus = 0;
    
    gss_display_status( &tempStatus, iMajorStatus, 
                        GSS_C_GSS_CODE, GSS_C_NULL_OID,
                        &message_context, &status_string );
    printf("\nGSS status: %s", status_string.value);
    
    gss_display_status( &tempStatus, iMinorStatus, 
                        GSS_C_MECH_CODE, GSS_C_NULL_OID, 
                        &message_context, &status_string );
                        
    printf("MECH status: %s\n", status_string.value);		
    
    return -1;
  }
  
  return 0;
}




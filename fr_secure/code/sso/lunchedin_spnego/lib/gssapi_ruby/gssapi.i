%feature("docstring") {
	/*
	Document-module: GSSAPI

  GSSAPI Module Things
	*/	
}

%module GSSAPI

// %feature("autodoc", 0);

%include "typemaps.i"
%include "gssapi_wrap.h"
	
%{

#include <stdio.h>
#include <string.h>
#include <gssapi.h>
#include <gssapi/gssapi.h>
#include <gssapi/gssapi_generic.h>
#include <gssapi/gssapi_krb5.h>
#include "gssapi_wrap.h"

%}

typedef unsigned int	  uint32_t;
typedef int 						int32_t;
typedef uint32_t 				gss_uint32;
typedef int32_t 				gss_int32;
typedef gss_uint32	 		OM_uint32;
typedef gss_int32				OM_int32;
typedef	int							gss_cred_usage_t;
typedef int							gss_qop_t;

%typedef unsigned int		uint32_t;
%typedef int  					int32_t;
%typedef uint32_t 			gss_uint32;
%typedef int32_t 				gss_int32;
%typedef gss_uint32 		OM_uint32;
%typedef gss_int32  		OM_int32;
%typedef int						gss_cred_usage_t;
%typedef int							gss_qop_t;

#ifndef KRB5_CALLCONV
#define KRB5_CALLCONV
#define KRB5_CALLCONV_C
#endif

struct gss_name_struct;
typedef struct gss_name_struct * gss_name_t;
%typedef struct gss_name_struct * gss_name_t;

struct gss_cred_id_struct;
typedef struct gss_cred_id_struct * gss_cred_id_t;
%typedef struct gss_cred_id_struct * gss_cred_id_t;

struct gss_ctx_id_struct;
typedef struct gss_ctx_id_struct * gss_ctx_id_t;
%typedef struct gss_ctx_id_struct * gss_ctx_id_t;

typedef struct gss_OID_desc_struct {
	OM_uint32 length;
	void *elements;
	} gss_OID_desc, *gss_OID;

typedef struct gss_OID_set_desc_struct  {
	size_t  count;
	gss_OID elements;
	} gss_OID_set_desc, *gss_OID_set;

typedef struct gss_buffer_desc_struct {
	size_t length;
	void *value;
	} gss_buffer_desc, *gss_buffer_t;

typedef struct gss_channel_bindings_struct {
	OM_uint32 initiator_addrtype;
	gss_buffer_desc initiator_address;
	OM_uint32 acceptor_addrtype;
	gss_buffer_desc acceptor_address;
	gss_buffer_desc application_data;
	} *gss_channel_bindings_t;


%extend gss_buffer_desc_struct {
	void setValueFromString(char * new_value) {
		if(new_value == NULL)
			return;
		int len = strlen(new_value) + 1;
		char *str;
		str = (char*)malloc(sizeof(char) * len);
		strncpy(str, new_value, len);
		$self->value = str;
		$self->length = strlen(str) + 1;
	}

	void setValueFromByteArray(char * new_value, int length) {
		$self->value = new_value;
		$self->length = length;
	}
	
	char *getValueAsString() {
		return (char*) $self->value;
	}
	
	%typemap(in,numinputs=0) char *OUT_ARRAY($1_ltype temp) {
		temp = ($1_ltype) malloc(sizeof($1_ltype));
		$1 = temp;
	}

	%typemap(in,numinputs=0) int *OUT_LEN($1_ltype temp) {
		temp = ($1_ltype) malloc(sizeof($1_ltype));
		$1 = temp;
	}

	%typemap(argout,fragment="output_helper") char *OUT_ARRAY {
		VALUE o = SWIG_FromCharPtrAndSize(arg1->value, arg1->length);
	  $result = output_helper($result, o);
	}
	
	void getValueAsByteArray(char *OUT_ARRAY, int *OUT_LEN) {
		OUT_ARRAY = (char *)$self->value;
 		OUT_LEN 	= (int *)&$self->length;
	}

};

/*
 * Flag bits for context-level services.
 */
#define GSS_C_DELEG_FLAG 1
#define GSS_C_MUTUAL_FLAG 2
#define GSS_C_REPLAY_FLAG 4
#define GSS_C_SEQUENCE_FLAG 8
#define GSS_C_CONF_FLAG 16
#define GSS_C_INTEG_FLAG 32
#define	GSS_C_ANON_FLAG 64
#define GSS_C_PROT_READY_FLAG 128
#define GSS_C_TRANS_FLAG 256

/*
 * Credential usage options
 */
#define GSS_C_BOTH 0
#define GSS_C_INITIATE 1
#define GSS_C_ACCEPT 2

/*
 * Status code types for gss_display_status
 */
#define GSS_C_GSS_CODE 1
#define GSS_C_MECH_CODE 2

/*
 * The constant definitions for channel-bindings address families
 */
#define GSS_C_AF_UNSPEC     0
#define GSS_C_AF_LOCAL      1
#define GSS_C_AF_INET       2
#define GSS_C_AF_IMPLINK    3
#define GSS_C_AF_PUP        4
#define GSS_C_AF_CHAOS      5
#define GSS_C_AF_NS         6
#define GSS_C_AF_NBS        7
#define GSS_C_AF_ECMA       8
#define GSS_C_AF_DATAKIT    9
#define GSS_C_AF_CCITT      10
#define GSS_C_AF_SNA        11
#define GSS_C_AF_DECnet     12
#define GSS_C_AF_DLI        13
#define GSS_C_AF_LAT        14
#define GSS_C_AF_HYLINK     15
#define GSS_C_AF_APPLETALK  16
#define GSS_C_AF_BSC        17
#define GSS_C_AF_DSS        18
#define GSS_C_AF_OSI        19
#define GSS_C_AF_X25        21

#define GSS_C_AF_NULLADDR   255

/*
 * Various Null values.
 */
#define GSS_C_NO_NAME 	  				((gss_name_t) 0)
#define GSS_C_NO_BUFFER 					((gss_buffer_t) 0)
#define GSS_C_NO_OID 							((gss_OID) 0)
#define GSS_C_NO_OID_SET 					((gss_OID_set) 0)
#define GSS_C_NO_CONTEXT 					((gss_ctx_id_t) 0)
#define GSS_C_NO_CREDENTIAL 			((gss_cred_id_t) 0)
#define GSS_C_NO_CHANNEL_BINDINGS ((gss_channel_bindings_t) 0)
#define GSS_C_EMPTY_BUFFER 				{0, NULL}

#define GSS_KRB5_INTEG_C_QOP_DES_MD5 0x0002
#define GSS_KRB5_INTEG_C_QOP_DES_MAC 0x0003

/*
 * Some alternate names for a couple of the above values.  These are defined
 * for V1 compatibility.
 */
#define	GSS_C_NULL_OID		GSS_C_NO_OID
#define	GSS_C_NULL_OID_SET	GSS_C_NO_OID_SET


/*
 * Define the default Quality of Protection for per-message services.  Note
 * that an implementation that offers multiple levels of QOP may either reserve
 * a value (for example zero, as assumed here) to mean "default protection", or
 * alternatively may simply equate GSS_C_QOP_DEFAULT to a specific explicit
 * QOP value.  However a value of 0 should always be interpreted by a GSSAPI
 * implementation as a request for the default protection level.
 */
#define GSS_C_QOP_DEFAULT 0

/*
 * Expiration time of 2^32-1 seconds means infinite lifetime for a
 * credential or security context
 */
#define GSS_C_INDEFINITE ((OM_uint32) 0xfffffffful)


/* Major status codes */

#define GSS_S_COMPLETE 0


#define GSS_C_CALLING_ERROR_OFFSET 24
#define GSS_C_ROUTINE_ERROR_OFFSET 16
#define GSS_C_SUPPLEMENTARY_OFFSET 0
#define GSS_C_CALLING_ERROR_MASK ((OM_uint32) 0377ul)
#define GSS_C_ROUTINE_ERROR_MASK ((OM_uint32) 0377ul)
#define GSS_C_SUPPLEMENTARY_MASK ((OM_uint32) 0177777ul)
/*
 * Supplementary info bits:
 */

#define GSS_S_CONTINUE_NEEDED (1 << (GSS_C_SUPPLEMENTARY_OFFSET + 0))
#define GSS_S_DUPLICATE_TOKEN (1 << (GSS_C_SUPPLEMENTARY_OFFSET + 1))
#define GSS_S_OLD_TOKEN (1 << (GSS_C_SUPPLEMENTARY_OFFSET + 2))
#define GSS_S_UNSEQ_TOKEN (1 << (GSS_C_SUPPLEMENTARY_OFFSET + 3))
#define GSS_S_GAP_TOKEN (1 << (GSS_C_SUPPLEMENTARY_OFFSET + 4))


#if defined (_WIN32) && defined (_MSC_VER)
# ifdef GSS_DLL_FILE
#  define GSS_DLLIMP __declspec(dllexport)
# else
#  define GSS_DLLIMP __declspec(dllimport)
# endif
#else
# define GSS_DLLIMP
#endif


// These don't swig well.  We'll define them manually
// TODO:  Get the capitalization to work correctly.
// GSS_DLLIMP extern gss_OID GSS_C_NT_USER_NAME;
// GSS_DLLIMP extern gss_OID GSS_C_NT_MACHINE_UID_NAME;
// GSS_DLLIMP extern gss_OID GSS_C_NT_STRING_UID_NAME;
// GSS_DLLIMP extern gss_OID GSS_C_NT_HOSTBASED_SERVICE_X;
// GSS_DLLIMP extern gss_OID GSS_C_NT_HOSTBASED_SERVICE;
// GSS_DLLIMP extern gss_OID GSS_C_NT_ANONYMOUS;
// GSS_DLLIMP extern gss_OID GSS_C_NT_EXPORT_NAME;
// TODO:  Fix casing for these methods after conversion.
const gss_OID NT_USER_NAME();
const gss_OID NT_MACHINE_UID_NAME();
const gss_OID NT_STRING_UID_NAME();
const gss_OID NT_HOSTBASED_SERVICE();
const gss_OID NT_ANONYMOUS();
const gss_OID NT_EXPORT_NAME();
const gss_OID_set NULL_OID_SET();

/* 
	Typemaps:  These give us the ability to reconcile the API to Ruby nicely.
*/

%define NEW_FROM_SWIG_PTR(type,swigtype,_ptr)
	VALUE o = SWIG_NewPointerObj(SWIG_as_voidptr(_ptr), 
							swigtype, 
							SWIG_POINTER_OWN );
%enddef

%define IN_OUT_TYPEMAPPER(_type, _swigtype, _ptr)
%typemap(in,numinputs=0) _type OUTPUT($1_ltype temp) {
	temp = ($1_ltype) malloc(sizeof($1_ltype));
	
	// SWIG_ConvertPtr(NULL, (void **) &temp, $1_descriptor, SWIG_POINTER_OWN); 
	$1 = temp;
}

%typemap(argout,fragment="output_helper") _type OUTPUT {
	NEW_FROM_SWIG_PTR(type, _swigtype, _ptr);
  $result = output_helper($result, o);
}
%enddef

IN_OUT_TYPEMAPPER(gss_name_t *, SWIGTYPE_p_gss_name_struct, *$1);
IN_OUT_TYPEMAPPER(gss_OID *, SWIGTYPE_p_gss_OID_desc_struct, $1);
IN_OUT_TYPEMAPPER(gss_OID_set *, SWIGTYPE_p_gss_OID_set_desc_struct, $1);
IN_OUT_TYPEMAPPER(gss_buffer_t, SWIGTYPE_p_gss_buffer_desc_struct, $1);
IN_OUT_TYPEMAPPER(gss_cred_id_t *, SWIGTYPE_p_gss_cred_id_struct, *$1);

%typemap(in,numinputs=0) gss_buffer_t OUTPUT2(gss_buffer_desc temp) {
	$1 = GSS_C_NO_BUFFER;
}

%typemap(in,numinputs=0) gss_buffer_t OUTPUT3($1_ltype temp) {
	$1 = malloc(sizeof(gss_buffer_t));
}

%typemap(argout,fragment="output_helper") gss_buffer_t OUTPUT3 {
	NEW_FROM_SWIG_PTR((gss_buffer_t), SWIGTYPE_p_gss_buffer_desc_struct, $1);
  $result = output_helper($result, o);
}

%typemap(in) gss_name_t * IN($*1_ltype temp) {
	SWIG_ConvertPtr($input, (void **) &temp, $1_descriptor, SWIG_POINTER_OWN); 
	$1 = &temp;
}

%typemap(in,numinputs=1) gss_ctx_id_t * OUTPUT($*1_ltype tmp_ctx) {
	if($input == Qnil) {
		tmp_ctx = GSS_C_NO_CONTEXT;
		$1 = &tmp_ctx;
	} else {
		void *vPtr = 0;
    // Check if vPtr is just a NULL -> (void *) NULL
		SWIG_ConvertPtr($input, &vPtr, $1_descriptor, SWIG_POINTER_OWN); 
		$1 = vPtr;
	}
}

%typemap(argout,fragment="output_helper") gss_ctx_id_t *OUTPUT {
	NEW_FROM_SWIG_PTR((gss_ctx_id_t *), SWIGTYPE_p_p_gss_ctx_id_struct, *$1);
  $result = output_helper($result, o);	 
}

%typemap(in) gss_ctx_id_t IN($1_ltype temp) {
	SWIG_ConvertPtr($input, (void **) &temp, $&1_descriptor, SWIG_POINTER_OWN); 
	// printf("ctx ptr: %p\n", temp);
	$1 = temp;
}


%apply gss_name_t 					*OUTPUT { gss_name_t *OUT };
%apply gss_name_t 					*IN { gss_name_t *IN };
%apply int 									*OUTPUT { OM_uint32  *OUT };
%apply gss_buffer_t  				 OUTPUT { gss_buffer_t OUT };
%apply gss_buffer_t  				 OUTPUT2 { gss_buffer_t OUT2 };
%apply gss_cred_id_t  			*OUTPUT { gss_cred_id_t *OUT };
%apply gss_ctx_id_t					*OUTPUT { gss_ctx_id_t *INOUT };
%apply gss_OID_set					*OUTPUT { gss_OID_set  *OUT };
%apply gss_OID							*OUTPUT { gss_OID  *OUT };
%apply int									*OUTPUT { gss_cred_usage_t  *OUT };
%apply int									*OUTPUT { int  *OUT };

// %apply gss_ctx_id_t					 IN			{ gss_ctx_id_t IN };


void printErrors(OM_uint32 iMajorStatus, OM_uint32 iMinorStatus);


%feature("docstring") {

/*
	  Document-method: gss_import_name

	  call-seq:
	    gss_import_name(GssBufferDesc name_buffer, opaque_name_type) -> [MajorStatus, MinorStatus, gss_name_t]

	A module function.
		
*/
}

OM_uint32 KRB5_CALLCONV gss_import_name
	(							
	OM_uint32  *OUT,	/* minor_status */
	gss_buffer_t,			/* input_name_buffer */
	gss_OID,			  	/* input_name_type(used to be const) */
	gss_name_t *OUT		/* output_name */
	);


// Returns:
// [MajorStatus, MinorStatus, MessageContext, StatusString]
// %feature("autodoc", "0");
OM_uint32 KRB5_CALLCONV gss_display_status
	(
	OM_uint32 *OUT,			/* minor_status */
	OM_uint32,					/* status_value => GSS_C_GSS_CODE | GSS_C_MECH_CODE */
	int,								/* status_type */
	gss_OID,						/* mech_type (used to be const) =>  GSS_C_NULL_OID  */
	OM_uint32   *OUT,		/* message_context */
	gss_buffer_t OUT 		/* status_string */
	);


// gss_acquire_cred(...) -> [MajorStatus, MinorStatus, gss_cred_id_t, gss_OID_set, TimeRec]
OM_uint32 KRB5_CALLCONV gss_acquire_cred
	(
	OM_uint32 				*OUT,				/* minor_status */
	gss_name_t 					IN,				/* desired_name  -> NULL means default */
	OM_uint32  					IN,				/* time_req */
	gss_OID_set					IN,				/* desired_mechs -> NULL means default */
	gss_cred_usage_t		IN,				/* 
			cred_usage 
	 		-- 0=INITIATE-AND-ACCEPT,
	 		-- 1=INITIATE-ONLY,
	   	-- 2=ACCEPT-ONLY 
	*/
	gss_cred_id_t 		*OUT,	  		/* output_cred_handle */
	// if returned non-NULL,
	// 	-- caller must release with GSS_Release_cred()
	gss_OID_set 			*OUT,				/* actual_mechs */
	// if returned non-NULL,
	//   -- caller must release with GSS_Release_oid_set()
	OM_uint32					*OUT				/* time_rec     */
	);

OM_uint32 KRB5_CALLCONV gss_display_name
	(OM_uint32  *OUT,		/* minor_status */
	gss_name_t    IN,			/* input_name */
	gss_buffer_t OUT,		/* output_name_buffer */
	gss_OID     *OUT		/* output_name_type */
	);

OM_uint32 KRB5_CALLCONV gss_inquire_cred
	(
		OM_uint32 *OUT,		/* minor_status */
		gss_cred_id_t,		/* cred_handle */
		gss_name_t *OUT,		/* name */
		OM_uint32 *OUT,		/* lifetime */
		gss_cred_usage_t *OUT,	/* cred_usage */
		gss_OID_set *OUT		/* mechanisms */
	);
	
// gss_release_cred(gss_cred_id_t *) -> [MajorStatus, MinorStatus]
OM_uint32 KRB5_CALLCONV gss_release_cred
	(
	OM_uint32 		 *OUT,					/* minor_status */
  gss_cred_id_t 	*IN						/* cred_handle */
  );

// ->[MajorStatus, MinorStatus, ReturnedContext, actual_mech_type, output_token, ret_flags, time_rec]
OM_uint32 KRB5_CALLCONV gss_init_sec_context
	(
	OM_uint32 		 				*OUT,		/* minor_status */
	gss_cred_id_t						IN,		/* claimant_cred_handle */
	gss_ctx_id_t 				*INOUT,		/* context_handle */
	gss_name_t						  IN,		/* target_name */
	gss_OID									IN,  	/* mech_type (used to be const) should use -> GSS_C_NO_OID for KRB5*/
	OM_uint32								IN,		/* req_flags */
	OM_uint32								IN,		/* time_req */
	gss_channel_bindings_t	IN, 	/* input_chan_bindings */
	gss_buffer_t						IN,		/* input_token */
	gss_OID *							 OUT,		/* actual_mech_type */
	gss_buffer_t					 OUT,		/* output_token */
	OM_uint32 *						 OUT,		/* ret_flags */
	OM_uint32 *						 OUT		/* time_rec */
	);


OM_uint32 KRB5_CALLCONV gss_accept_sec_context
	(
	OM_uint32 		   			*OUT,		/* minor_status */
	gss_ctx_id_t 	 			*INOUT,		/* context_handle */
	gss_cred_id_t						IN,		/* acceptor_cred_handle */
	gss_buffer_t						IN,		/* input_token_buffer */
	gss_channel_bindings_t	IN,		/* input_chan_bindings */
	gss_name_t 						*OUT,		/* src_name */
	gss_OID					  		*OUT,	  /* mech_type */
	gss_buffer_t					 OUT, 	/* output_token */
	OM_uint32 *						 OUT, 	/* ret_flags */
	OM_uint32 * 					 OUT,		/* time_rec */
	gss_cred_id_t *				 OUT		/* delegated_cred_handle */
	);


OM_uint32 KRB5_CALLCONV gss_process_context_token
	(
	OM_uint32 *	 	 				OUT,		/* minor_status */
	gss_ctx_id_t 					 IN,		/* context_handle */
	gss_buffer_t					 IN			/* token_buffer */
	);

OM_uint32 KRB5_CALLCONV gss_delete_sec_context
	(OM_uint32 *				  OUT,		/* minor_status */
	gss_ctx_id_t *			   IN,		/* context_handle */
	gss_buffer_t				  OUT2			/* output_token */
	);
	
OM_uint32 KRB5_CALLCONV gss_release_name
	(OM_uint32 *OUT,		/* minor_status */
	gss_name_t *IN		/* input_name */
	);

OM_uint32 KRB5_CALLCONV gss_release_buffer
	(OM_uint32 		*OUT,		/* minor_status */
	gss_buffer_t	IN	/* buffer */
	);

OM_uint32 KRB5_CALLCONV gss_export_name
	(OM_uint32  *OUT,		/* minor_status */
	const gss_name_t,	/* input_name */
	gss_buffer_t OUT		/* exported_name */
	);
	
OM_uint32 KRB5_CALLCONV gss_wrap
(
	OM_uint32 		  *OUT,		/* minor_status */
	gss_ctx_id_t		  IN,		/* context_handle */
	int							  IN,			/* conf_req_flag */
	gss_qop_t				  IN,			/* qop_req */
	gss_buffer_t		  IN,		/* input_message_buffer */
	int 				 		*OUT,			/* conf_state */
	gss_buffer_t		 OUTPUT3	/* output_message_buffer */
	);

OM_uint32 KRB5_CALLCONV gss_unwrap
(
	OM_uint32  			*OUT,		/* minor_status */
  gss_ctx_id_t 			IN,		/* context_handle */
  gss_buffer_t 			IN,		/* input_message_buffer */
  gss_buffer_t 		 OUT,		/* output_message_buffer */
  int 						*OUT,		/* conf_state */
  gss_qop_t 			*OUT		/* qop_state */
  );	
/*
			KERBEROS / GSSAPI Stuff
*/

GSS_DLLIMP extern const gss_OID_desc * const GSS_KRB5_NT_PRINCIPAL_NAME;

OM_uint32 KRB5_CALLCONV krb5_gss_register_acceptor_identity(const char *);

OM_uint32 KRB5_CALLCONV gss_krb5_get_tkt_flags 
	(OM_uint32 *OUT,
	gss_ctx_id_t context_handle,
	krb5_flags *ticket_flags);

OM_uint32 KRB5_CALLCONV gss_krb5_copy_ccache
	(OM_uint32 *OUT,
	gss_cred_id_t cred_handle,
	krb5_ccache out_ccache);

OM_uint32 KRB5_CALLCONV gss_krb5_ccache_name
	(OM_uint32 *OUT, const char *name,
	const char **out_name);

// Copyright (C) 2002 Microsoft Corporation
// All rights reserved.
//
// THIS CODE AND INFORMATION IS PROVIDED "AS IS"
// WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
// OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE IMPLIED WARRANTIES OF MERCHANTIBILITY
// AND/OR FITNESS FOR A PARTICULAR PURPOSE.
//
// Date    - 10/08/2002
// Author  - Sanj Surati

/////////////////////////////////////////////////////////////
//
// MAIN.C
//
// SPNEGO Token Handler Test Appplication
//
/////////////////////////////////////////////////////////////

#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include "spnego.h"
#include "spnegodata.h"

#pragma warning ( disable: 4100 )

int main ( int argc, char* argv[] )
{
   int            nReturn;
   SPNEGO_TOKEN_HANDLE  hSpnegoToken = NULL;
   SPNEGO_MECH_OID       mechoid;
   int            nMechOidIndex = 0L;
   unsigned char *   pbData = NULL;
   unsigned long     ulDataLen = 0L;
   unsigned char     ucContextFlags = 0L;
   SPNEGO_NEGRESULT  spnegoNegResult;


   printf( "***************************\n\n");
   printf( "Testing NegTokenInit: Begin\n");

   // Check out an Init Token
   if ( ( nReturn = spnegoInitFromBinary( g_ucSpnegoInitToken, sizeof(g_ucSpnegoInitToken),
                                             &hSpnegoToken ) ) == SPNEGO_E_SUCCESS )
   {

      printf( "spnegoInitFromBinary succeeded!\n");

      // Test for Kerberos V5 OneOff
      nReturn = spnegoIsMechTypeAvailable( hSpnegoToken, spnego_mech_oid_Kerberos_V5_Legacy, &nMechOidIndex );

      if ( SPNEGO_E_SUCCESS == nReturn )
      {
         printf( "spnegoIsMechTypeAvailable (Kerberos V5 Legacy) succeeded!\n");
      }
      else
      {
         printf( "spnegoIsMechTypeAvailable (Kerberos V5 Legacy) failed: 0x%x!\n", nReturn);
      }

      // Test for Kerberos V5 Primary
      nReturn = spnegoIsMechTypeAvailable( hSpnegoToken, spnego_mech_oid_Kerberos_V5, &nMechOidIndex );

      if ( SPNEGO_E_SUCCESS == nReturn )
      {
         printf( "spnegoIsMechTypeAvailable (Kerberos V5) succeeded!\n");
      }
      else
      {
         printf( "spnegoIsMechTypeAvailable (Kerberos V5) failed: 0x%x!\n", nReturn);
      }

      nReturn = spnegoGetContextFlags( hSpnegoToken, &ucContextFlags );

      if ( SPNEGO_E_SUCCESS == nReturn )
      {
         printf( "spnegoGetContextFlags succeeded!\n");
      }
      else
      {
         printf( "spnegoGetContextFlags failed: 0x%x!\n", nReturn);
      }


      // Allocate a buffer for the token
      nReturn = spnegoGetMechToken( hSpnegoToken, NULL, &ulDataLen );

      if ( SPNEGO_E_BUFFER_TOO_SMALL == nReturn )
      {
         pbData = (unsigned char *) malloc( ulDataLen );

         // Make the real call
         nReturn = spnegoGetMechToken( hSpnegoToken, pbData, &ulDataLen );

         if ( SPNEGO_E_SUCCESS == nReturn )
         {
            printf( "spnegoGetMechToken succeeded!\n");

            if ( ulDataLen == GSS_KERB_INIT_TOKEN_SIZE &&
                 memcmp( pbData, g_ucGSSKerbInitToken, ulDataLen ) == 0L )
            {
               printf( "Comparing MechToken succeeded!\n");
            }
            else
            {
               printf( "Comparing MechToken Failed!\n");
            }

         }
         else
         {
            printf( "spnegoGetMechToken failed: 0x%x!\n", nReturn);
         }

         // Cleanup
         free( pbData );

      }
      else
      {
         printf( "spnegoGetMechToken failed: 0x%x!\n", nReturn);
      }

      // Allocate a buffer for the MIC
      nReturn = spnegoGetMechListMIC( hSpnegoToken, NULL, &ulDataLen );

      if ( SPNEGO_E_BUFFER_TOO_SMALL == nReturn )
      {
         pbData = (unsigned char *) malloc( ulDataLen );

         // Make the real call
         nReturn = spnegoGetMechListMIC( hSpnegoToken, pbData, &ulDataLen );

         if ( SPNEGO_E_SUCCESS == nReturn )
         {
            printf( "spnegoGetMechListMIC succeeded!\n");
         }
         else
         {
            printf( "spnegoGetMechListMIC failed: 0x%x!\n", nReturn);
         }

         // Cleanup
         free( pbData );

      }
      else
      {
         printf( "spnegoGetMechListMIC failed: 0x%x!\n", nReturn);
      }


      spnegoFreeData( hSpnegoToken );

   }
   else
   {
      printf( "spnegoInitFromBinary failed: 0x%x!\n", nReturn);
   }

   printf( "Testing NegTokenInit: End\n\n");
   printf( "***************************\n\n\n");


   printf( "***************************\n\n");
   printf( "Testing NegTokenTarg: Begin\n");

   // Check out a response token
   if ( ( nReturn = spnegoInitFromBinary( g_ucSpnegoRespToken, sizeof(g_ucSpnegoRespToken),
                                             &hSpnegoToken ) ) == SPNEGO_E_SUCCESS )
   {

      printf( "spnegoInitFromBinary succeeded!\n");

      nReturn = spnegoGetNegotiationResult( hSpnegoToken, &spnegoNegResult );

      if ( SPNEGO_E_SUCCESS == nReturn )
      {
         printf( "spnegoGetNegotiationResult succeeded!\n");
      }
      else
      {
         printf( "spnegoGetNegotiationResult failed: 0x%x!\n", nReturn);
      }

      nReturn = spnegoGetSupportedMechType( hSpnegoToken, &mechoid );

      if ( SPNEGO_E_SUCCESS == nReturn )
      {
         printf( "spnegoGetSupportedMechType succeeded!\n");
      }
      else
      {
         printf( "spnegoGetSupportedMechType failed: 0x%x!\n", nReturn);
      }


      // Allocate a buffer for the token
      nReturn = spnegoGetMechToken( hSpnegoToken, NULL, &ulDataLen );

      if ( SPNEGO_E_BUFFER_TOO_SMALL == nReturn )
      {
         pbData = (unsigned char *) malloc( ulDataLen );

         // Make the real call
         nReturn = spnegoGetMechToken( hSpnegoToken, pbData, &ulDataLen );

         if ( SPNEGO_E_SUCCESS == nReturn )
         {
            printf( "spnegoGetMechToken succeeded!\n");

            if ( ulDataLen == GSS_KERB_RESP_TOKEN_SIZE &&
                 memcmp( pbData, g_ucGSSKerbRespToken, ulDataLen ) == 0L )
            {
               printf( "Comparing MechToken succeeded!\n");
            }
            else
            {
               printf( "Comparing MechToken Failed!\n");
            }

         }
         else
         {
            printf( "spnegoGetMechToken failed: 0x%x!\n", nReturn);
         }

         // Cleanup
         free( pbData );

      }
      else
      {
         printf( "spnegoGetMechToken failed: 0x%x!\n", nReturn);
      }

      // Allocate a buffer for the MIC
      nReturn = spnegoGetMechListMIC( hSpnegoToken, NULL, &ulDataLen );

      if ( SPNEGO_E_BUFFER_TOO_SMALL == nReturn )
      {
         pbData = (unsigned char *) malloc( ulDataLen );

         // Make the real call
         nReturn = spnegoGetMechListMIC( hSpnegoToken, pbData, &ulDataLen );

         if ( SPNEGO_E_SUCCESS == nReturn )
         {
            printf( "spnegoGetMechListMIC succeeded!\n");
         }
         else
         {
            printf( "spnegoGetMechListMIC failed: 0x%x!\n", nReturn);
         }

         // Cleanup
         free( pbData );

      }
      else
      {
         printf( "spnegoGetMechListMIC failed: 0x%x!\n", nReturn);
      }


      spnegoFreeData( hSpnegoToken );

   }
   else
   {
      printf( "spnegoInitFromBinary failed: 0x%x!\n", nReturn);
   }

   printf( "Testing NegTokenTarg: End\n\n");
   printf( "***************************\n\n\n");

   printf( "***************************\n\n");
   printf( "Testing Bad Init Token: Begin\n");



   // This is a bad token
   if ( ( nReturn = spnegoInitFromBinary( ucBadSpnegoInitToken, sizeof(ucBadSpnegoInitToken),
                                             &hSpnegoToken ) ) == SPNEGO_E_SUCCESS )
   {

      printf( "spnegoInitFromBinary succeeded!\n");

      spnegoFreeData( hSpnegoToken );

   }
   else
   {
      printf( "spnegoInitFromBinary failed: 0x%x!\n", nReturn);
   }

   printf( "Testing Bad Init Token: End\n\n");
   printf( "***************************\n\n\n");
   
   printf( "***************************\n\n");
   printf( "Testing Create Init Token: Begin\n");


   if ( ( nReturn = spnegoCreateNegTokenInit( spnego_mech_oid_Kerberos_V5_Legacy,
                                             SPNEGO_NEGINIT_CONTEXT_DELEG_FLAG, g_ucGSSKerbInitToken, GSS_KERB_INIT_TOKEN_SIZE,
                                             NULL, 0L, &hSpnegoToken ) ) == SPNEGO_E_SUCCESS )
   {
      printf( "spnegoCreateNegTokenInit succeeded!\n");

      // See if we can properly retrieve the MechToken
      // Allocate a buffer for the token
      nReturn = spnegoGetMechToken( hSpnegoToken, NULL, &ulDataLen );

      if ( SPNEGO_E_BUFFER_TOO_SMALL == nReturn )
      {
         pbData = (unsigned char *) malloc( ulDataLen );

         // Make the real call
         nReturn = spnegoGetMechToken( hSpnegoToken, pbData, &ulDataLen );

         if ( SPNEGO_E_SUCCESS == nReturn )
         {
            printf( "spnegoGetMechToken succeeded!\n");

            // Now compare the MechToken to the value we passed in.
            // It better be the same

            if ( ulDataLen == GSS_KERB_INIT_TOKEN_SIZE &&
                  memcmp( g_ucGSSKerbInitToken, pbData, ulDataLen ) == 0 )
            {
               printf( "MechToken Compare succeeded!\n");

               // Now check the Context Flags
               if ( ( nReturn = spnegoGetContextFlags( hSpnegoToken, &ucContextFlags ) )
                              == SPNEGO_E_SUCCESS )
               {
                  if ( ucContextFlags == SPNEGO_NEGINIT_CONTEXT_DELEG_FLAG )
                  {
                     printf( "Context Flags Compare succeeded!\n");
                  }
                  else
                  {
                     printf( "Context Flags Compare failed!\n");
                  }
               }
               else
               {
                  printf( "spnegoGetContextFlags failed: 0x%x!\n", nReturn);
               }
            }
            else
            {
               printf( "MechToken Compare failed!\n");
            }
         }
         else
         {
            printf( "spnegoGetMechToken failed: 0x%x!\n", nReturn);
         }

         // Cleanup
         free( pbData );

      }
      else
      {
         printf( "spnegoGetMechToken failed: 0x%x!\n", nReturn);
      }


      spnegoFreeData( hSpnegoToken );
   }
   else
   {
      printf( "spnegoCreateNegTokenInit failed: 0x%x!\n", nReturn);
   }

   printf( "Testing Create Init Token: End\n\n");
   printf( "***************************\n\n\n");

   printf( "***************************\n\n");
   printf( "Testing Create Targ Token 1: Begin\n");


   if ( ( nReturn = spnegoCreateNegTokenTarg( spnego_mech_oid_Kerberos_V5_Legacy,
                                             0L, g_ucGSSKerbRespToken, GSS_KERB_RESP_TOKEN_SIZE,
                                             NULL, 0L, &hSpnegoToken ) ) == SPNEGO_E_SUCCESS )
   {
      printf( "spnegoCreateNegTokenTarg succeeded!\n");

      nReturn = spnegoGetNegotiationResult( hSpnegoToken, &spnegoNegResult );

      if ( SPNEGO_E_SUCCESS == nReturn )
      {
         printf( "spnegoGetNegotiationResult succeeded!\n");
      }
      else
      {
         printf( "spnegoGetNegotiationResult failed: 0x%x!\n", nReturn);
      }

      nReturn = spnegoGetSupportedMechType( hSpnegoToken, &mechoid );

      if ( SPNEGO_E_SUCCESS == nReturn )
      {
         printf( "spnegoGetSupportedMechType succeeded!\n");
      }
      else
      {
         printf( "spnegoGetSupportedMechType failed: 0x%x!\n", nReturn);
      }

      // See if we can properly retrieve the MechToken
      // Allocate a buffer for the token
      nReturn = spnegoGetMechToken( hSpnegoToken, NULL, &ulDataLen );

      if ( SPNEGO_E_BUFFER_TOO_SMALL == nReturn )
      {
         pbData = (unsigned char *) malloc( ulDataLen );

         // Make the real call
         nReturn = spnegoGetMechToken( hSpnegoToken, pbData, &ulDataLen );

         if ( SPNEGO_E_SUCCESS == nReturn )
         {
            printf( "spnegoGetMechToken succeeded!\n");

            // Now compare the MechToken to the value we passed in.
            // It better be the same

            if ( ulDataLen == GSS_KERB_RESP_TOKEN_SIZE &&
                  memcmp( g_ucGSSKerbRespToken, pbData, ulDataLen ) == 0 )
            {
               printf( "MechToken Compare succeeded!\n");
            }
            else
            {
               printf( "MechToken Compare failed!\n");
            }
         }
         else
         {
            printf( "spnegoGetMechToken failed: 0x%x!\n", nReturn);
         }

         // Cleanup
         free( pbData );

      }
      else
      {
         printf( "spnegoGetMechToken failed: 0x%x!\n", nReturn);
      }


      spnegoFreeData( hSpnegoToken );
   }
   else
   {
      printf( "spnegoCreateNegTokenTarg failed: 0x%x!\n", nReturn);
   }

   printf( "Testing Create Targ Token 1: End\n\n");
   printf( "***************************\n\n\n");

   printf( "***************************\n\n");
   printf( "Testing Create Targ Token 2: Begin\n");


   if ( ( nReturn = spnegoCreateNegTokenTarg( spnego_mech_oid_NotUsed,
                                             spnego_negresult_NotUsed,
                                             g_ucGSSKerbRespToken, GSS_KERB_RESP_TOKEN_SIZE,
                                             NULL, 0L, &hSpnegoToken ) ) == SPNEGO_E_SUCCESS )
   {
      printf( "spnegoCreateNegTokenTarg succeeded!\n");

      nReturn = spnegoGetNegotiationResult( hSpnegoToken, &spnegoNegResult );

      if ( SPNEGO_E_SUCCESS == nReturn )
      {
         printf( "spnegoGetNegotiationResult succeeded!\n");
      }
      else
      {
         printf( "spnegoGetNegotiationResult failed: 0x%x!\n", nReturn);
      }

      nReturn = spnegoGetSupportedMechType( hSpnegoToken, &mechoid );

      if ( SPNEGO_E_SUCCESS == nReturn )
      {
         printf( "spnegoGetSupportedMechType succeeded!\n");
      }
      else
      {
         printf( "spnegoGetSupportedMechType failed: 0x%x!\n", nReturn);
      }

      // See if we can properly retrieve the MechToken
      // Allocate a buffer for the token
      nReturn = spnegoGetMechToken( hSpnegoToken, NULL, &ulDataLen );

      if ( SPNEGO_E_BUFFER_TOO_SMALL == nReturn )
      {
         pbData = (unsigned char *) malloc( ulDataLen );

         // Make the real call
         nReturn = spnegoGetMechToken( hSpnegoToken, pbData, &ulDataLen );

         if ( SPNEGO_E_SUCCESS == nReturn )
         {
            printf( "spnegoGetMechToken succeeded!\n");

            // Now compare the MechToken to the value we passed in.
            // It better be the same

            if ( ulDataLen == GSS_KERB_RESP_TOKEN_SIZE &&
                  memcmp( g_ucGSSKerbRespToken, pbData, ulDataLen ) == 0 )
            {
               printf( "MechToken Compare succeeded!\n");
            }
            else
            {
               printf( "MechToken Compare failed!\n");
            }
         }
         else
         {
            printf( "spnegoGetMechToken failed: 0x%x!\n", nReturn);
         }

         // Cleanup
         free( pbData );

      }
      else
      {
         printf( "spnegoGetMechToken failed: 0x%x!\n", nReturn);
      }


      spnegoFreeData( hSpnegoToken );
   }
   else
   {
      printf( "spnegoCreateNegTokenTarg failed: 0x%x!\n", nReturn);
   }

   printf( "Testing Create Targ Token 2: End\n\n");
   printf( "***************************\n\n\n");

   printf( "***************************\n\n");
   printf( "Testing Create Targ Token 3: Begin\n");

   // This should fail
   if ( ( nReturn = spnegoCreateNegTokenTarg( spnego_mech_oid_NotUsed,
                                             spnego_negresult_success,
                                             g_ucGSSKerbRespToken, GSS_KERB_RESP_TOKEN_SIZE,
                                             NULL, 0L, &hSpnegoToken ) ) == SPNEGO_E_SUCCESS )
   {
      printf( "spnegoCreateNegTokenTarg succeeded!\n");
      spnegoFreeData( hSpnegoToken );
   }
   else
   {
      printf( "spnegoCreateNegTokenTarg failed: 0x%x!\n", nReturn);
   }

   printf( "Testing Create Targ Token 3: End\n\n");
   printf( "***************************\n\n\n");

   return 0;
}
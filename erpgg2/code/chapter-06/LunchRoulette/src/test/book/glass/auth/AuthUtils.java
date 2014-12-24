/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass.auth;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.google.api.client.auth.oauth2.AuthorizationCodeFlow;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.auth.oauth2.StoredCredential;
import com.google.api.client.extensions.appengine.datastore.AppEngineDataStoreFactory;
import com.google.api.client.extensions.appengine.http.UrlFetchTransport;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.store.DataStore;

public final class AuthUtils
{
  public static final List<String> SCOPES = Arrays.asList(
    "https://www.googleapis.com/auth/userinfo.profile",
    "https://www.googleapis.com/auth/glass.timeline",
    "https://www.googleapis.com/auth/glass.location"
  );
  public static final String WEB_CLIENT_ID =
      "[MY_NUMBER].apps.googleusercontent.com";
  public static final String WEB_CLIENT_SECRET = "[MY_SECRET_KEY]";
  public static final String OAUTH2_PATH = "/oauth2callback";
  public static final String API_KEY = "[MY_API_KEY]";

  public static Credential getCredential(String userId) throws IOException {
    return userId == null ? null : buildCodeFlow().loadCredential( userId );
  }

  public static void deleteCredential(String userId) throws IOException {
    getDataStore().delete( userId );
  }

  public static boolean hasAccessToken(String userId) {
    try {
      Credential cred = getCredential(userId);
      return (cred != null && cred.getAccessToken() != null);
    } catch (IOException e) {
      return false;
    }
  }

  public static DataStore<StoredCredential> getDataStore()
    throws IOException
  {
    AppEngineDataStoreFactory factory = AppEngineDataStoreFactory.getDefaultInstance();
    return StoredCredential.getDefaultDataStore( factory );
  }

  /**
   * Gets the credentials stored in GAE. If expired, uses the refresh token to
   * get a new access token from OAuth
   * @return
   * @throws IOException
   */
  public static AuthorizationCodeFlow buildCodeFlow()
      throws IOException
  {
    return new GoogleAuthorizationCodeFlow.Builder(
        new UrlFetchTransport(),
        new JacksonFactory(),
        WEB_CLIENT_ID,
        WEB_CLIENT_SECRET,
        SCOPES)
    .setApprovalPrompt( "force" )
    .setAccessType("offline")
    .setCredentialDataStore( getDataStore() )
    .build();
  }
  
  public static String fullUrl( HttpServletRequest req, String rawPath )
  {
    GenericUrl url = new GenericUrl( new String(req.getRequestURL()) );
    url.setRawPath( rawPath );
    return url.build();
  }
}

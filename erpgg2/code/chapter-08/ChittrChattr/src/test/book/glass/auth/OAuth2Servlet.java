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
import java.util.Collections;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.book.glass.MirrorUtils;
import test.book.glass.SessionUtils;
import test.book.glass.blog.models.Blog;
import test.book.glass.blog.models.User;

import com.google.api.client.auth.oauth2.AuthorizationCodeFlow;
import com.google.api.client.auth.oauth2.AuthorizationCodeTokenRequest;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.auth.oauth2.TokenResponse;
import com.google.api.client.extensions.appengine.http.UrlFetchTransport;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.mirror.Mirror;
import com.google.api.services.mirror.model.Command;
import com.google.api.services.mirror.model.Contact;
import com.google.api.services.mirror.model.Subscription;
import com.google.api.services.oauth2.Oauth2;
import com.google.api.services.oauth2.model.Userinfoplus;

/**
 * URL endpoint which handles all oauth requests.
 * GET requests without a code will redirect to Google's authorization code flow.
 * GET requests with a code will 
 */
@SuppressWarnings("serial")
public class OAuth2Servlet extends HttpServlet
{
  private static final String PROD_BASE_URL = "https://chittrchattr.appspot.com";

  protected void doGet( HttpServletRequest req, HttpServletResponse res )
      throws IOException
  {
    if( !hasError(req, res) ) {
      res.sendRedirect( doAuth(req) );
    }
  }

  private boolean hasError( HttpServletRequest req, HttpServletResponse res )
      throws IOException
  {
    String error = req.getParameter( "error" );
    if( error != null ) {
      res.getWriter().write( "Sorry, auth failed because: " + error );
      return true;
    }
    return false;
  }
  
  private String doAuth(HttpServletRequest req)
      throws IOException
  {
    String authCode = req.getParameter( "code" );

    String callbackUri = AuthUtils.fullUrl( req, AuthUtils.OAUTH2_PATH );

    // We need a flow no matter what to either redirect or extract information
    AuthorizationCodeFlow flow = AuthUtils.buildCodeFlow();

    // Without a response code, redirect to Google's authorization URI
    if( authCode == null ) {
      return flow.newAuthorizationUrl().setRedirectUri( callbackUri ).build();
    }

    // With a response code, store the user's credential, and 
    // set the user's ID into the session
    GoogleTokenResponse tokenRes = getTokenRes( flow, authCode, callbackUri );

    // Extract the Google user ID from the ID token in the auth response
    String userId = getUserId( tokenRes );

    // Store the credential with the user
    Credential creds = flow.createAndStoreCredential( tokenRes, userId );

    User user = User.get( userId );

    // TODO: if there's a SessionUtils.getNickname, then 
    if( user == null ) {
      Oauth2 service = new Oauth2.Builder(
          new UrlFetchTransport(), 
          new JacksonFactory(),
          creds)
      .setApplicationName("blog")
      .build();

      Userinfoplus userinfo = service.userinfo().get().execute();

      String email = userinfo.getEmail();
      String name = userinfo.getName();
      user = new User( userId, email, name );
      user = user.save();
    }

    // If a blog is in session and this user has no
    // blog, we assume they are attempting to create one
    Blog blog = SessionUtils.getBlog( req );
    if( blog != null ) {
      synchronized (Blog.class) {
        if( Blog.get( blog.getNickname() ) == null ) {
          blog.setUserId( user.getId() );
          blog = blog.save();
//          user.setBlog( blog );
        }
      }
    }

    // clear out any lingering session nickname
    SessionUtils.removeBlog( req );

    // Store the user if for the session
    SessionUtils.setUser( req, user );

    Mirror mirror = MirrorUtils.getMirror( req );

    Contact contact = new Contact()
      .setId("chittrchattr")
      .setImageUrls( Collections.singletonList( 
          PROD_BASE_URL + "/static/images/chittrchattr.png" ) )
      .setPriority( 100L )
      .setAcceptCommands(
          Collections.singletonList(new Command().setType("TAKE_A_NOTE")))
      .setDisplayName("ChittrChattr")
      .setSpeakableName("chitter chatter");

    mirror.contacts().insert( contact ).execute();
    
    Subscription subscription = new Subscription()
      .setCallbackUrl( PROD_BASE_URL + "/postcallback" )
      .setVerifyToken( "a_secret_to_everybody" )
      .setUserToken( userId )
      .setCollection( "timeline" )
      .setOperation( Collections.singletonList( "UPDATE" ) );

    mirror.subscriptions().insert( subscription ).execute();
    
    return "/";
  }

  /**
   * Makes a remote call to the Google Auth server to authorize the grant code,
   * in order to issue a request token.
   * @param flow
   * @param code
   * @param callbackUri
   * @return
   * @throws IOException
   */
  private GoogleTokenResponse getTokenRes( AuthorizationCodeFlow flow, String code, String callbackUri ) 
      throws IOException
  {
    AuthorizationCodeTokenRequest tokenReq = flow
        .newTokenRequest( code )
        .setRedirectUri( callbackUri );

    TokenResponse tokenRes = tokenReq.execute();
    
    return (GoogleTokenResponse)tokenRes;
  }

  /**
   * Extract the Google user ID from the ID token in the auth response
   */
  private String getUserId( GoogleTokenResponse tokenRes )
      throws IOException
  {
    return tokenRes.parseIdToken().getPayload().getSubject();
  }
}
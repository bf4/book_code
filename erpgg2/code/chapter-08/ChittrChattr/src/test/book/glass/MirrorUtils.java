/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import test.book.glass.auth.AuthUtils;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.appengine.http.UrlFetchTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.mirror.Mirror;

public final class MirrorUtils
{
  public static Mirror getMirror( HttpServletRequest req )
      throws IOException
  {
    String userId = SessionUtils.getUserId( req );
    Credential credential = AuthUtils.getCredential(userId);
    return getMirror(credential);
  }

  public static Mirror getMirror( String userId )
      throws IOException
  {
    Credential credential = AuthUtils.getCredential(userId);
    return getMirror(credential);
  }

  public static Mirror getMirror( Credential credential )
      throws IOException
  {
    return new Mirror.Builder(
        new UrlFetchTransport(),
        new JacksonFactory(),
        credential)
    .setApplicationName("ChittrChattr")
    .build();
  }
}

/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass.blog.mirror;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.book.glass.MirrorUtils;
import test.book.glass.blog.BlogHelper;
import test.book.glass.blog.models.User;

import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.mirror.Mirror;
import com.google.api.services.mirror.model.Contact;
import com.google.api.services.mirror.model.Notification;
import com.google.api.services.mirror.model.TimelineItem;
import com.google.api.services.mirror.model.UserAction;

@SuppressWarnings("serial")
public class PostCallbackServlet extends HttpServlet
{
  protected void doPost(HttpServletRequest req, HttpServletResponse res)
      throws IOException, ServletException
  {
    // Generate Notification from request body
    JsonFactory jsonFactory = new JacksonFactory();
    Notification notification =
      jsonFactory.fromInputStream( req.getInputStream(), Notification.class );

    // Get this user action's type
    UserAction launchAction = null;
    for (UserAction userAction : notification.getUserActions()) {
      if( "LAUNCH".equals( userAction.getType() ) ) {
        launchAction = userAction;
        break;
      }
    }
    // return, because this is the wrong kind of user action 
    if( launchAction == null ) return;

    String userId = notification.getUserToken();
    String itemId = notification.getItemId();

    Mirror mirror = MirrorUtils.getMirror( userId );
    TimelineItem timelineItem = mirror.timeline().get( itemId ).execute();

    // ensure that ChittrChattr is one of this post's intended recipients
    boolean belongsHere = false;
    for( Contact contact : timelineItem.getRecipients() ) {
      if( "chittrchattr".equals( contact.getId() ) ) {
        belongsHere = true;
        break;
      }
    }
    // return, because this post wasn't intended for ChittrChattr
    if( !belongsHere ) return;

    // at this point we have the body text, and the user intended us to have it

    String body = timelineItem.getText();
    User user = User.get( userId );
    BlogHelper.createPost( null, body, user );
  }
}

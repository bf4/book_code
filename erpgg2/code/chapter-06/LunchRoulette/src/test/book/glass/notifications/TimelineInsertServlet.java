/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass.notifications;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.book.glass.LunchRoulette;
import test.book.glass.MirrorUtils;

import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.mirror.Mirror;
import com.google.api.services.mirror.Mirror.Timeline;
import com.google.api.services.mirror.Mirror.Timeline.Attachments;
import com.google.api.services.mirror.model.Attachment;
import com.google.api.services.mirror.model.Location;
import com.google.api.services.mirror.model.Notification;
import com.google.api.services.mirror.model.TimelineItem;
import com.google.appengine.api.datastore.Blob;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@SuppressWarnings("serial")
public class TimelineInsertServlet extends HttpServlet
{
  protected void doPost(HttpServletRequest req, HttpServletResponse res)
      throws IOException, ServletException
  {
    // Generate Notification from request body
    JsonFactory jsonFactory = new JacksonFactory();
    Notification notification =
      jsonFactory.fromInputStream( req.getInputStream(), Notification.class );

    // Get this user action's type
    String userActionType = null;
    if( !notification.getUserActions().isEmpty() )
      userActionType = notification.getUserActions().get(0).getType();

    String userId = notification.getUserToken();
    String itemId = notification.getItemId();

    // If this is a shared timeline item, log who and which timeline item
    if( "SHARE".equals( userActionType ) )
    {
      System.out.format( "User %s shared %s", userId, itemId );

      Mirror mirror = MirrorUtils.getMirror( userId );
      Timeline timeline = mirror.timeline();
      Attachments attachments = timeline.attachments();

      // get the newly created timeline item that triggered this notification
      TimelineItem timelineItem = timeline.get( itemId ).execute();

      // get the first attachment's id and content type
      Attachment attachment = timelineItem.getAttachments().get(0);
      String contentType = attachment.getContentType();
      String attachmentId = attachment.getId();

      // download the attachment image data
      ByteArrayOutputStream data = new ByteArrayOutputStream();
      attachments.get(itemId, attachmentId).executeMediaAndDownloadTo( data ); 
      byte[] image = data.toByteArray();
      Blob blob = new Blob( image );
      // Save the image in the datastore
      DatastoreService store = DatastoreServiceFactory.getDatastoreService();

      // Get the current location of Glass
      Location location = mirror.locations().get("latest").execute();
      String keyValue = String.format("%.3f,%.3f",
          location.getLatitude(), location.getLongitude());
      // Store the image, type, and hash
      Key key = KeyFactory.createKey("image", keyValue);
      Entity entity = new Entity( key );
      entity.setProperty("image", blob);
      entity.setProperty("type", contentType);
      entity.setProperty("hash", LunchRoulette.toSHA1( image ));
      store.put(entity);
    }
  }
}

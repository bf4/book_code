/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass.notifications;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.Collections;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.book.glass.MirrorUtils;

import com.google.api.client.http.InputStreamContent;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.mirror.Mirror;
import com.google.api.services.mirror.Mirror.Locations;
import com.google.api.services.mirror.Mirror.Timeline;
import com.google.api.services.mirror.model.Location;
import com.google.api.services.mirror.model.MenuItem;
import com.google.api.services.mirror.model.Notification;
import com.google.api.services.mirror.model.TimelineItem;
import com.google.appengine.api.datastore.Blob;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@SuppressWarnings("serial")
public class LocationsUpdateServlet extends HttpServlet
{
  protected void doPost(HttpServletRequest req, HttpServletResponse res)
      throws IOException, ServletException
  {
    // Generate Notification from request body
    JsonFactory jsonFactory = new JacksonFactory();
    Notification notification =
      jsonFactory.fromInputStream( req.getInputStream(), Notification.class );

    String userId = notification.getUserToken();
    String itemId = notification.getItemId();

    Mirror mirror = MirrorUtils.getMirror( userId );
    Locations locations = mirror.locations();
    Timeline timeline = mirror.timeline();

    // create a key of the user's current location
    Location location = locations.get( itemId ).execute();
    String positionKey = String.format("%.3f,%.3f",
        location.getLatitude(), location.getLongitude());

    DatastoreService store = DatastoreServiceFactory.getDatastoreService();

    // Build a key to retrieve the image, and store that it's been shown
    Key imageKey = KeyFactory.createKey("image", positionKey);
    Key shownKey = KeyFactory.createKey(imageKey, "shown", userId);
    
    String shownImageHash = null;
    try {
      Entity shown = store.get( shownKey );
      shownImageHash = (String)shown.getProperty("hash");
    } catch( EntityNotFoundException e ) {
      // the user has never seen this, carry on
    }
    try {
      // Get the image data from the store
      Entity entity = store.get( imageKey );
      String contentType = (String)entity.getProperty("type");
      Blob blob = (Blob)entity.getProperty("image");
      String imageHash = (String)entity.getProperty("hash");
      byte[] image = blob.getBytes();
      ByteArrayInputStream data = new ByteArrayInputStream( image );

      // only show this if the image hash is different
      if( shownImageHash != null && shownImageHash.equals(imageHash)) {
        // nothing to do here, we've already see this
        return;
      }
      
      // create and insert a new timeline item with attachment
      TimelineItem timelineItem = new TimelineItem()
        .setText( "Compliments of Lunch Roulette" )
        .setMenuItems( Collections.singletonList(
            new MenuItem().setAction( "DELETE" )));
      InputStreamContent content = new InputStreamContent( contentType, data );
      timeline.insert( timelineItem, content ).execute();

      // save that this user has seen this image at this location 
      Entity shown = new Entity( shownKey );
      entity.setProperty("hash", imageHash);
      store.put( shown );
    } catch( EntityNotFoundException e ) {
      // there was no matching image found
    }
  } 
}

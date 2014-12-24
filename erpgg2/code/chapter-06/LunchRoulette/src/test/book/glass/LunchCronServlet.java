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
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;

@SuppressWarnings("serial")
public class LunchCronServlet extends HttpServlet
{
  /**
   * For every user stored, add a timeline item
   */
  protected void doGet(HttpServletRequest req, HttpServletResponse res)
      throws IOException, ServletException
  {
    res.setContentType("text/plain");

    if( !"true".equals(req.getHeader("X-AppEngine-Cron")) ) {
      res.setStatus(403);
      res.getWriter().append("Only cron can deliver lunches");
      return;
    }

    ServletContext ctx = getServletContext();

    List<Key> removeKeys = new LinkedList<Key>();

    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Query q = new Query("User"); // StoredCredential
    PreparedQuery pq = datastore.prepare(q);
    for( Entity result : pq.asIterable() )
    {
      String userId = (String)result.getProperty("id");
      try {
        LunchRoulette.insertAndSaveSimpleHtmlTimelineItem(ctx, userId);
      } catch (GoogleJsonResponseException e) {
        // remove invalid user from the back end
        removeKeys.add( result.getKey() );
      }
    }
    
    System.out.print( "Removing keys: " );
    System.out.println( removeKeys );
    datastore.delete( removeKeys );

    res.getWriter().append("Delivered lunches!");
  }
}

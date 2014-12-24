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

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.api.services.mirror.Mirror.Timeline;
import com.google.api.services.mirror.model.TimelineItem;

@SuppressWarnings("serial")
public class LunchRouletteServlet extends HttpServlet
{
  public void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws IOException, ServletException
  {
    ServletContext ctx = getServletContext();
    
    String userId = SessionUtils.getUserId( req );
    TimelineItem timelineItem = LunchRoulette.getLastSavedTimelineItem(userId);

    // If it exists, isn't deleted, and is pinned, then update
    if (timelineItem != null
        && !(timelineItem.getIsDeleted() != null && timelineItem.getIsDeleted())
        && (timelineItem.getIsPinned() != null && timelineItem.getIsPinned()))
    {
      String html = LunchRoulette.renderRandomCuisine( ctx );
      timelineItem.setHtml( html );

      // update the old timeline item
      Timeline timeline = MirrorUtils.getMirror( userId ).timeline();
      timeline.patch( timelineItem.getId(), timelineItem ).execute();
    }
    // Otherwise, create a new one
    else {
      LunchRoulette.insertAndSaveSimpleHtmlTimelineItem( ctx, userId );
    }

    resp.setContentType("text/plain");
    resp.getWriter().append( "Inserted Timeline Item" );
  }
}

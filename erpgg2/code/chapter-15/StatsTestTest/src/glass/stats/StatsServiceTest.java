/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.stats;

import android.content.Intent;
import android.test.ServiceTestCase;

import com.google.android.glass.timeline.LiveCard;

public class StatsServiceTest
  extends ServiceTestCase<StatsService>
{
  private StatsService service;
  public StatsServiceTest() {
    super( StatsService.class );
  }
  @Override
  protected void setUp() throws Exception {
    super.setUp();
    Intent intent = new Intent( getContext(), StatsService.class );
    startService( intent );
    service = getService();
    assertNotNull( service );
  }

  public void testLiveCardIsPublished() {
    LiveCard liveCard = service.getLiveCard();
    assertNotNull( liveCard );
    assertTrue( liveCard.isPublished() );
  }
}

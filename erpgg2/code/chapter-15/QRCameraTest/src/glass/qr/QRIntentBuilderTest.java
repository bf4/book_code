/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.qr;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.test.AndroidTestCase;

public class QRIntentBuilderTest
  extends AndroidTestCase
{
  public void testWeb() {
    QRIntentBuilder ib = new QRIntentBuilder("http://pragprog.com");
    Intent intent = ib.buildIntent();
    assertNotNull( intent );
    assertEquals( Intent.ACTION_VIEW, intent.getAction() );
    Uri uri = intent.getData();
    assertNotNull( uri );
    assertEquals( "http", uri.getScheme() );
    assertEquals( "pragprog.com", uri.getHost() );
  }

  public void testLocation() {
    String ll = "45.5200,-122.6819";
    QRIntentBuilder ib = new QRIntentBuilder(ll);
    Intent intent = ib.buildIntent();
    assertNotNull( intent );
    assertEquals( Intent.ACTION_VIEW, intent.getAction() );
    Uri uri = intent.getData();
    assertNotNull( uri );
    assertEquals( "google.navigation", uri.getScheme() );
    assertEquals( "google.navigation:ll="+ll+"&mode=mru", uri.toString() );
  }

  public void testText() {
    String message = "Hello there!";
    QRIntentBuilder ib = new QRIntentBuilder(message);
    Intent intent = ib.buildIntent();
    assertNotNull( intent );
    Bundle extras = intent.getExtras();
    assertNotNull( extras );
    assertEquals( message, extras.get("text") );
  }
}
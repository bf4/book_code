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

/**
 * Builds an intent based on the given QR string. Supported types are:
 * 
 * URLs launch the web browser
 * Phone numbers launch the phone app
 * Geolocation (lat/long or addresses) launches navigation
 * 
 * @author eric redmond
 * @twitter coderoshi
 */
public class QRIntentBuilder
{
  // TODO: Text generates a static card in the timeline
  private String qrText;

  public QRIntentBuilder(String qrText) {
    this.qrText = qrText;
  }

  public Intent buildIntent() {
    switch(getType()) {
    case URL:
      return new Intent(Intent.ACTION_VIEW, Uri.parse(qrText));
//    case PHONE:
//      return new Intent(Intent.ACTION_VIEW, buildPhoneUri());
    case LOCATION:
      return new Intent(Intent.ACTION_VIEW, buildNavUri());
    default:
      return new Intent().putExtra("text", qrText);
    }
  }

  enum Type { URL, LOCATION, UNKNOWN; } //PHONE, 

  private Type getType() {
    if( qrText.matches("https?://.*") ) {
      // matches: http://pragprog.com
      return Type.URL;
    } else if( qrText.matches("\\-?\\d{1,3}\\.?\\d{0,9},\\-?\\d{1,3}\\.?\\d{0,9}") ) {
      // matches: 37.4219795,-122.0836669
      return Type.LOCATION;
//    } else if( qrText.matches("(tel:|TEL:)?[+]?(\\d[ \\.-]?){5,16}") ) {
//      // matches: +1-800-555-1212
//      return Type.PHONE;
    }
    return Type.UNKNOWN;
  }


  private Uri buildNavUri() {
    return Uri.parse("google.navigation:ll=" + qrText + "&mode=mru");
  }

//  private Uri buildPhoneUri() {
//    String telText = qrText;
//    if( qrText.toLowerCase().startsWith("tel:") ) {
//      telText = qrText.substring( "tel:".length() );
//    }
//    return Uri.parse("tel:" + telText);
//  }
}

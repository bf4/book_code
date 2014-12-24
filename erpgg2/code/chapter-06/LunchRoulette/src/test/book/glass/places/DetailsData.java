/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass.places;

import java.util.HashMap;
import java.util.Map;

@SuppressWarnings("serial")
public final class DetailsData extends HashMap<String, Object>
{
  public static final String BASE_URL =
      "https://maps.googleapis.com/maps/api/place/details/json";

  /**
   * Fills out details not returned by a regular search. Namely,
   * address and phone number
   * @param place
   */
  @SuppressWarnings("unchecked")
  public void populatePlace( Place place )
  {
    Map<String, Object> result = (Map<String, Object>)get("result");
    place.setAddress( (String)result.get("formatted_address") );
    place.setPhone( (String)result.get("international_phone_number") );
  }
}

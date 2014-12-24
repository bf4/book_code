/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass.places;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@SuppressWarnings("serial")
public final class SearchData extends HashMap<String, Object>
{
  public static final String BASE_URL =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
  
  @SuppressWarnings("unchecked")
  public List<Place> buildPlaces()
  {
    LinkedList<Place> places = new LinkedList<Place>();

    List<Map<String, Object>> results =
        (List<Map<String, Object>>)get("results");
    
    for( Map<String, Object> data : results )
    {
      Place place = new Place();
      try {
        place.setName( (String)data.get("name") );
        //place.address = (String)data.get("vicinity");
        place.setReference( (String)data.get("reference") ); 

        Map<String,Object> geometry =
            (Map<String,Object>)data.get("geometry");
        Map<String,BigDecimal> location =
            (Map<String,BigDecimal>)geometry.get("location");

        place.setLatitude( location.get("lat").doubleValue() );
        place.setLongitude( location.get("lng").doubleValue() );

        places.add(place);
      } catch (Exception e) {
        e.printStackTrace();
      }
    }

    return places;
  }
}

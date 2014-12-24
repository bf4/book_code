/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass.places;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Random;

import test.book.glass.auth.AuthUtils;

import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestFactory;
import com.google.api.client.http.HttpResponse;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonParser;
import com.google.api.client.json.jackson2.JacksonFactory;

public final class PlaceUtils
{
  /**
   * Makes a call to Google Places and returns a nearby restaurant matching
   * the suggested style (french, italian, etc).
   * @param lat
   * @param lng
   * @param style
   * @return
   * @throws IOException
   */
  public static Place getRandom( String kind, String type, double lat, double lng )
    throws IOException
  {
    List<Place> places = performSearch( kind, type, lat, lng );
    
    if(places.isEmpty()) return null;

    int choice = new Random().nextInt(places.size());
    Place place = places.get(choice);
    place.setKind( kind );
    
    return populateDetails( place );
  }

  private static List<Place> performSearch( String kind, String type, double lat, double lng )
      throws IOException
  {
    HttpTransport httpTransport = new NetHttpTransport();
    HttpRequestFactory hrf = httpTransport.createRequestFactory();
    
    String paramsf = "%s?location=%f,%f&rankby=distance&keyword=%s&type=%s&sensor=true&key=%s";
    String params = String.format(paramsf, SearchData.BASE_URL, lat, lng, type, kind, AuthUtils.API_KEY);
    GenericUrl url = new GenericUrl(params);
    HttpRequest hreq = hrf.buildGetRequest(url);
    HttpResponse hres = hreq.execute();

    InputStream content = hres.getContent();
    JsonParser p = new JacksonFactory().createJsonParser(content);
    SearchData searchData = p.parse(SearchData.class, null);
    
    return searchData.buildPlaces();
  }

  private static Place populateDetails( Place place )
      throws IOException
  {
    // grab more restaurant details
    HttpTransport httpTransport = new NetHttpTransport();
    HttpRequestFactory hrf = httpTransport.createRequestFactory();

    String paramsf = "%s?reference=%s&sensor=true&key=%s";
    String params = String.format(paramsf, DetailsData.BASE_URL, place.getReference(), AuthUtils.API_KEY);
    GenericUrl url = new GenericUrl(params);
    HttpRequest hreq = hrf.buildGetRequest(url);
    HttpResponse hres = hreq.execute();

//    ByteArrayOutputStream os = new ByteArrayOutputStream();
//    IOUtils.copy(hres.getContent(), os, false);
//    System.out.println( os.toString() );

    InputStream content2 = hres.getContent();
    JsonParser p = new JacksonFactory().createJsonParser(content2);
    DetailsData details = p.parse(DetailsData.class, null);
    details.populatePlace( place );

    return place;
  }
}

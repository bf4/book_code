/***
 * Excerpted from "Hello, Android",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/eband4 for more book information.
***/
package org.example.suggest;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.LinkedList;
import java.util.List;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

import android.util.Log;
import android.util.Xml;

public class SuggestTask implements Runnable {
   private static final String TAG = "SuggestTask";
   private final MainActivity suggest;
   private final String original;

   SuggestTask(MainActivity context, String original) {
      this.suggest = context;
      this.original = original;
   }

   public void run() {
      // Get suggestions for the original text
      List<String> suggestions = doSuggest(original);
      suggest.setSuggestions(suggestions);
   }

   /**
    * Call the Google Suggest API to create a list of suggestions
    * from a partial string.
    * 
    * Note: This isn't really a supported API so if it breaks, try
    * the Yahoo one instead:
    * 
    * http://ff.search.yahoo.com/gossip?output=xml&command=WORD or
    * http://ff.search.yahoo.com/gossip?output=fxjson&command=WORD
    */
   private List<String> doSuggest(String original) {
      List<String> messages = new LinkedList<String>();
      String error = null;
      HttpURLConnection con = null;
      Log.d(TAG, "doSuggest(" + original + ")");

      try {
         // Check if task has been interrupted
         if (Thread.interrupted())
            throw new InterruptedException();

         // Build RESTful query for Google API
         String q = URLEncoder.encode(original, "UTF-8");
         URL url = new URL(
               "http://google.com/complete/search?output=toolbar&q="
                     + q);
         con = (HttpURLConnection) url.openConnection();
         con.setReadTimeout(10000 /* milliseconds */);
         con.setConnectTimeout(15000 /* milliseconds */);
         con.setRequestMethod("GET");
         con.addRequestProperty("Referer",
               "http://www.pragprog.com/book/eband4");
         con.setDoInput(true);

         // Start the query
         con.connect();

         // Check if task has been interrupted
         if (Thread.interrupted())
            throw new InterruptedException();

         // Read results from the query
         XmlPullParser parser = Xml.newPullParser();
         parser.setInput(con.getInputStream(), null);
         int eventType = parser.getEventType();
         while (eventType != XmlPullParser.END_DOCUMENT) {
            String name = parser.getName();
            if (eventType == XmlPullParser.START_TAG
                  && name.equalsIgnoreCase("suggestion")) {
               for (int i = 0; i < parser.getAttributeCount(); i++) {
                  if (parser.getAttributeName(i).equalsIgnoreCase(
                        "data")) {
                     messages.add(parser.getAttributeValue(i));
                  }
               }
            }
            eventType = parser.next();
         }

         // Check if task has been interrupted
         if (Thread.interrupted())
            throw new InterruptedException();

      } catch (IOException e) {
         Log.e(TAG, "IOException", e);
         error = suggest.getResources().getString(R.string.error)
               + " " + e.toString();
      } catch (XmlPullParserException e) {
         Log.e(TAG, "XmlPullParserException", e);
         error = suggest.getResources().getString(R.string.error)
               + " " + e.toString();
      } catch (InterruptedException e) {
         Log.d(TAG, "InterruptedException", e);
         error = suggest.getResources().getString(
               R.string.interrupted);
      } finally {
         if (con != null) {
            con.disconnect();
         }
      }

      // If there was an error, return the error by itself
      if (error != null) {
         messages.clear();
         messages.add(error);
      }

      // Print something if we got nothing
      if (messages.size() == 0) {
         messages.add(suggest.getResources().getString(
               R.string.no_results));
      }

      // All done
      Log.d(TAG, "   -> returned " + messages);
      return messages;
   }
}

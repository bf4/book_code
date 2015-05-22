/***
 * Excerpted from "Hello, Android",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/eband4 for more book information.
***/
package org.example.events;


import android.net.Uri;
// ...

import android.provider.BaseColumns;

public interface Constants extends BaseColumns {
   public static final String TABLE_NAME = "events";
   
   public static final String AUTHORITY = "org.example.events";
   public static final Uri CONTENT_URI = Uri.parse("content://"
         + AUTHORITY + "/" + TABLE_NAME);
   

   // Columns in the MainActivity database
   public static final String TIME = "time";
   public static final String TITLE = "title";
}

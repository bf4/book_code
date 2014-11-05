/***
 * Excerpted from "Seven Concurrency Models in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/pb7con for more book information.
***/
package com.paulbutcher;

import java.util.regex.*;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

class Contribution {
  static final Pattern pattern = Pattern.compile("^([^\\s]*) (\\d*) (\\d*) (.*)$"); 
  static final DateTimeFormatter isoFormat = ISODateTimeFormat.dateTimeNoMillis(); 

  public long timestamp;
  public int id;
  public int contributorId;
  public String username;

  public Contribution(String line) {
    Matcher matcher = pattern.matcher(line);
    if(matcher.find()) {
      timestamp = isoFormat.parseDateTime(matcher.group(1)).getMillis(); 
      id = Integer.parseInt(matcher.group(2));
      contributorId = Integer.parseInt(matcher.group(3));
      username = matcher.group(4);
    }
  }
}

/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
public java.lang.String serializeHashToString(java.util.HashMap hash) {
  com.google.gson.Gson gson = new com.google.gson.Gson();
  return gson.toJson(hash);
}

public java.util.HashMap[] deserializeHashMapArray(java.io.Reader reader) {
  com.google.gson.Gson gson = new com.google.gson.Gson();
  return gson.fromJson(reader, java.util.HashMap[].class);
}

/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
public void addSerializableExtra(
    android.content.Intent intent,
    java.lang.String key,
    java.io.Serializable value) {
  intent.putExtra(key, (java.io.Serializable)value);
}

/***
 * Excerpted from "Using JRuby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
***/
public class GetType {
    public static String fredsType() {
        return
            // Java:
            "Fred".getClass().getName(); // => java.lang.String
    }

    public static void main(String[] args) {
        System.out.println(GetType.fredsType());
    }
}

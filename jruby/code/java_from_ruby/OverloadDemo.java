/***
 * Excerpted from "Using JRuby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
***/
import java.util.List;

public class OverloadDemo {
    public static String whatTypeIs(long value) {
        return "long";
    }

    public static String whatTypeIs(String value) {
        return "string";
    }

    public static String whatTypeIs(Object value) {
        return "object";
    }
}

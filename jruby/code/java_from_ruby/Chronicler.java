/***
 * Excerpted from "Using JRuby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
***/
import java.lang.annotation.Annotation;

public class Chronicler {
    public static void describe(Class<?> c) {
        PerformedBy p = (PerformedBy)c.getAnnotation(PerformedBy.class);
        System.out.println(p.name() + " performs " + c.getName());
    }
}

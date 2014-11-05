/***
 * Excerpted from "Using JRuby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
***/
import java.math.BigInteger;

public class BigIntDemo {
    public static final BigInteger GOOGOL =
        new BigInteger("10").pow(100);

    public static boolean biggerThanGoogol(BigInteger i) {
        return (GOOGOL.compareTo(i) < 0);
    }
}

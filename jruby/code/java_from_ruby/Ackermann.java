/***
 * Excerpted from "Using JRuby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
***/
public class Ackermann {
    public static int ack(int m, int n) {
        if (m == 0)
            return n + 1;

        if (n == 0)
            return ack(m - 1, 1);

        return ack(m - 1, ack(m, n - 1));
    }
}

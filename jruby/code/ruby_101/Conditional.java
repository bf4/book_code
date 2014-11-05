/***
 * Excerpted from "Using JRuby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
***/
public class Conditional {
    private int getNumberFromSomewhere() {
        return 2;
    }

    public void printGroupName() {
        // Java:
        String result = "";

        switch (getNumberFromSomewhere()) {
        case 2:  result = "twins";       break;
        case 3:  result = "triplets";    break;
        case 4:  result = "quadruplets"; break;
        default: result = "unknown";     break;
        }

        System.out.println(result);
    }
}
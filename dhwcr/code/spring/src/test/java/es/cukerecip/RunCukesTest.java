/***
 * Excerpted from "Cucumber Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
***/
package es.cukerecip;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;
@RunWith(Cucumber.class)
@Cucumber.Options(glue = {"es.cukerecip", "cucumber.runtime.java.spring.hooks"})

public class RunCukesTest {
}

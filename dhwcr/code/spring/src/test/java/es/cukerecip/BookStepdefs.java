/***
 * Excerpted from "Cucumber Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
***/
package es.cukerecip;
import cucumber.api.java.en.Given;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;
public class BookStepdefs {
    @Autowired
    private BookRepository bookRepository;
    @Given("^a writer has contributed to the following books:$")
    public void a_writer_has_contributed_to_the_following_books( 
        List<Book> books) throws Throwable {

        for (Book b : books) {
            bookRepository.save(b);
        }
    }
}

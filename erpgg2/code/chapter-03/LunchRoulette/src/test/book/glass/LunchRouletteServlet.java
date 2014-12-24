/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class LunchRouletteServlet extends HttpServlet
{
  /** Accepts an HTTP GET request, and writes a random lunch type. */
  public void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws IOException, ServletException
  {
    resp.setContentType("text/html; charset=utf-8");

    Map<String, Object> data = new HashMap<String, Object>();
    data.put("food", LunchRoulette.getRandomCuisine());

    String html = LunchRoulette.render(
        getServletContext(), "web/cuisine.ftl", data);
    resp.getWriter().append(html);
  }
}

/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass.blog;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.book.glass.SessionUtils;
import test.book.glass.ViewUtils;
import test.book.glass.auth.BaseServlet;
import test.book.glass.blog.models.Blog;

@SuppressWarnings("serial")
public class HomeServlet extends BaseServlet
{
  protected void doGet( HttpServletRequest req, HttpServletResponse res )
      throws IOException, ServletException
  {
    Map<String, Object> data = new HashMap<String, Object>();
    int page = ViewUtils.getPage( req );
    data.put( "pg", Blog.getBlogs( page ) );
    data.put( "user", SessionUtils.getUser( req ) );
    render( res, "index.ftl", data );
  }
}

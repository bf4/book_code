/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.book.glass.SessionUtils;

@SuppressWarnings("serial")
public class LogoutServlet extends HttpServlet
{
  protected void doGet( HttpServletRequest req, HttpServletResponse res )
      throws ServletException, IOException
  {
    AuthUtils.deleteCredential( SessionUtils.getUserId(req) );
    SessionUtils.removeUserId( req );
    res.getWriter().write( "Goodbye!" );
  }
}

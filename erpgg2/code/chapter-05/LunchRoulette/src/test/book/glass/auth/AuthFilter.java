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
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.book.glass.SessionUtils;

public class AuthFilter implements Filter
{
  private Pattern excludesPattern;

  public void doFilter(ServletRequest req, ServletResponse res, FilterChain fc)
    throws IOException, ServletException
  {
    HttpServletRequest request = (HttpServletRequest)req;
    HttpServletResponse response = (HttpServletResponse)res;

    // If this path is not destined for a redirectable URI
    // and has no access token, redirect to the oauth2 path
    if (isRedirectable(request)
        && !AuthUtils.hasAccessToken(SessionUtils.getUserId(request)))
    {
      response.sendRedirect( AuthUtils.OAUTH2_PATH );
      return;
    }

    // execute any remaining filters
    fc.doFilter( request, response );
  }

  private boolean isRedirectable(HttpServletRequest request) {
    return !excludesPattern.matcher( request.getRequestURI() ).matches();
  }

  public void init(FilterConfig fc) throws ServletException {
    String excludes = fc.getInitParameter("excludes");
    if( excludes == null ) {
      excludes = "^$";
    }
    this.excludesPattern = Pattern.compile( excludes );
  }
  public void destroy() {}
}

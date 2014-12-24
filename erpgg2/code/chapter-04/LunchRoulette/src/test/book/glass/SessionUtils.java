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

import javax.servlet.http.HttpServletRequest;

public final class SessionUtils
{
  public static String getUserId(HttpServletRequest request) {
    return (String)request.getSession().getAttribute("userId");
  }

  public static void setUserId(HttpServletRequest request, String userId) {
    request.getSession().setAttribute("userId", userId);
  }

  public static void removeUserId(HttpServletRequest request) throws IOException {
    // Remove their ID from the local session
    request.getSession().removeAttribute("userId");
  }
}

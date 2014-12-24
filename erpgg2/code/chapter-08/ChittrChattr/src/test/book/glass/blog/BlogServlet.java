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
import test.book.glass.auth.AuthUtils;
import test.book.glass.auth.BaseServlet;
import test.book.glass.blog.models.Blog;
import test.book.glass.blog.models.User;

@SuppressWarnings("serial")
public class BlogServlet extends BaseServlet
{
  /**
   * Display an HTML where someone can create a new blog
   */
  protected void doGet( HttpServletRequest req, HttpServletResponse res )
      throws IOException, ServletException
  {
    String errorMsg = req.getParameter("error");
    String error = "";
    if("nonick".equals(errorMsg)) {
      error = "You must provide a nickname for your blog";
    }
    else if("dupnick".equals(errorMsg)) {
      error = "That nickname is already in use, try again";
    }

    Map<String, Object> data = new HashMap<String, Object>();
    data.put( "error", error );
    data.put( "user", SessionUtils.getUser( req ) );
    render( res, "new_blog.ftl", data );
  }  
  
  /**
   * Accept the data required to create a new blog
   */
  protected void doPost( HttpServletRequest req, HttpServletResponse res )
      throws IOException, ServletException
  {
    String nickname = req.getParameter( "nickname" );
    if( isBlank(nickname) ) {
      res.sendRedirect( "/blog?error=nonick" );
      return;
    }
    nickname = nickname.toLowerCase();

    // if it can't store this nickname, it's not unique
    if( Blog.get( nickname ) != null ) {
      res.sendRedirect( "/blog?error=dupnick" );
      return;
    }

    String title = req.getParameter( "title" );
    if( isBlank(title) ) {
      title = nickname + "' blog";
    }

    Blog blog = new Blog( null, nickname, title );

    // if already logged in, just make a blog
    if( SessionUtils.isLoggedIn( req ) ) {
      User user = SessionUtils.getUser( req );
      blog.setUserId( user.getId() );
      blog.save();
      
      // TODO: stop saving user to session. just save key
      // TODO: this won't save to session, so what's the point?
//      user.setBlog( blog );
    }
    // else, save nickname in session and fwd to oauth 
    else {
      // store the unfinished blog in the session
      SessionUtils.setBlog(req, blog);

      // forward to oauth servlet
      res.sendRedirect( AuthUtils.OAUTH2_PATH );
    }
  }

  private boolean isBlank( String value ) {
    return value == null || "".equals(value.trim());
  }
}

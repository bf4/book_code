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
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.book.glass.SessionUtils;
import test.book.glass.ViewUtils;
import test.book.glass.auth.BaseServlet;
import test.book.glass.blog.models.Blog;
import test.book.glass.blog.models.User;

@SuppressWarnings("serial")
public class PostServlet extends BaseServlet
{
  /**
   * Show a list of posts for a single blog
   */
  protected void doGet( HttpServletRequest req, HttpServletResponse res )
      throws IOException, ServletException
  {
    String nickname = ViewUtils.extractFromPath( req );
    Blog blog = Blog.get( nickname );
    if( blog == null ) {
      res.sendRedirect( "/" );
      return;
    }

    User user = SessionUtils.getUser( req );
    int page = ViewUtils.getPage( req );
    boolean followed = false;
    if( user != null ) {
      followed = user.getFollowedBlogs().contains( nickname );
    }

    Map<String, Object> data = new HashMap<String, Object>();
    data.put( "ownsBlog", (user != null && user.ownsBlog(blog)) );
    data.put( "user", user);
    data.put( "blog", blog );
    data.put( "pg", blog.getPosts( page ) );
    data.put( "notFollowed", !followed );
    render( res, "posts.ftl", data );
  }

  public void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws IOException, ServletException
  {
    String nickname = req.getParameter( "nickname" );
    Blog blog = Blog.get( nickname );
    User user = SessionUtils.getUser( req );

    String title = req.getParameter( "title" );
    String body = req.getParameter( "body" );

    BlogHelper.createPost(title, body, user, blog);

    resp.sendRedirect( "/posts/" + URLEncoder.encode( blog.getNickname(), "UTF8" ) );
  }
}

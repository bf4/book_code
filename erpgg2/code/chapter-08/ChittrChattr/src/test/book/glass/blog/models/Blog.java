/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass.blog.models;

import java.io.Serializable;
import java.util.List;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.PrimaryKey;

import test.book.glass.PMF;
import test.book.glass.PageList;

@PersistenceCapable
public class Blog extends Base<Blog> implements Serializable
{
  private static final long serialVersionUID = -4911950040606690310L;

  @PrimaryKey
  private String nickname;
  private String title;
  private String userId;

  public static Blog get( String nickname )
  {
    PersistenceManager pm = PMF.get().getPersistenceManager();
    try {
      return pm.getObjectById( Blog.class, nickname );
    } catch( JDOObjectNotFoundException e ) {
      return null;
    } finally {
      pm.close();
    }
  }

  /**
   * Get every user whose followedBlogs contains this blog's nickname
   */
  @SuppressWarnings("unchecked")
  public List<User> getFollowers()
  {
    PersistenceManager pm = PMF.get().getPersistenceManager();
    Query q = pm.newQuery( User.class );
    q.setFilter("followedBlogs.contains(:nickname)");
    List<User> users = (List<User>)q.execute(nickname);
    
    return users;
  }
  
  @SuppressWarnings("unchecked")
  public static PageList<Blog> getBlogs( int page )
  {
    if( page < 1 ) page = 1;
    page -= 1;
    long offset = page * 10L;

    PersistenceManager pm = PMF.get().getPersistenceManager();
    Query q = pm.newQuery( Blog.class );
    q.setRange(offset, offset + 11);
    List<Blog> blogs = (List<Blog>)q.execute();

    // grab 11 to see if there are any more, then pop the last one
    boolean more = blogs.size() > 10;
    if(more) blogs = blogs.subList( 0, 10 );

    return new PageList<Blog>(blogs, page, more);
  }

  @SuppressWarnings("unchecked")
  public PageList<Post> getPosts( int page )
  {
    if( page < 1 ) page = 1;
    page -= 1;
    long offset = page * 10L;

    PersistenceManager pm = PMF.get().getPersistenceManager();
    Query q = pm.newQuery( Post.class );
    q.setFilter("blogKey == :nickname");
    q.setOrdering("timestamp desc");
    q.setRange(offset, offset + 11);
    List<Post> posts = (List<Post>)q.execute(nickname);

    // grab 11 to see if there are any more, then pop the last one
    boolean more = posts.size() > 10;
    if(more) posts = posts.subList( 0, 10 );

    return new PageList<Post>(posts, page, more);
  }

  public Blog( String userId, String nickname, String title ) {
    this.userId = userId;
    this.nickname = nickname;
    this.title = title;
  }

  public String getUserId()
  {
    return userId;
  }
  
  public void setUserId(String userId)
  {
    this.userId = userId;
  }

  public String getNickname()
  {
    return nickname;
  }

  public void setNickname( String nickname )
  {
    this.nickname = nickname;
  }

  public String getTitle()
  {
    return title;
  }

  public void setTitle(String title)
  {
    this.title = title;
  }
}

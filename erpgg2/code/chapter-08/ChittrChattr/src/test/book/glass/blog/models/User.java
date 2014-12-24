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
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.PrimaryKey;

import test.book.glass.PMF;
import test.book.glass.PageList;

@PersistenceCapable
public class User extends Base<User> implements Serializable
{
  private static final long serialVersionUID = -8601863868331626350L;

  @PrimaryKey
  private String id;
  private String email;
  private String name;
  private Set<String> followedBlogs;
  private transient Blog blog;

  public User( String id, String email, String name )
  {
    this.id = id;
    this.email = email;
    this.name = name;
    this.followedBlogs = new HashSet<String>();
  }

  public static User get( String id )
  {
    PersistenceManager pm = PMF.get().getPersistenceManager();
    try {
      return pm.getObjectById( User.class, id );
    } catch( JDOObjectNotFoundException e ) {
      return null;
    } finally {
      pm.close();
    }
  }

  @SuppressWarnings("unchecked")
  public Blog getBlog()
  {
    if( blog != null ) return blog;
    PersistenceManager pm = PMF.get().getPersistenceManager();
    try {
      Query q = pm.newQuery( Blog.class );
      q.setFilter("userId == :userId");
      q.setRange(0, 1);
      List<Blog> blogs = (List<Blog>)q.execute(getId());

      if( blogs.isEmpty() ) return null;
      blog = blogs.get(0);
      return blog;
    } catch( JDOObjectNotFoundException e ) {
      return null;
    } finally {
      pm.close();
    }
  }

  public boolean ownsBlog( Blog blog )
  {
    return getId() != null && getId().equals( blog.getUserId() );
  }

  public void followBlog(String nickname)
  {
    if(this.followedBlogs == null) {
      this.followedBlogs = new HashSet<String>();
    }
    this.followedBlogs.add( nickname );
  }

  public void setFollowedBlogs(Set<String> followedBlogs)
  {
    this.followedBlogs = followedBlogs;
  }
  
  public Set<String> getFollowedBlogs()
  {
    return followedBlogs;
  }

  @SuppressWarnings("unchecked")
  public PageList<Post> getFollowedPosts( int page )
  {
    if( page < 1 ) page = 1;
    page -= 1;
    long offset = page * 10L;

    PersistenceManager pm = PMF.get().getPersistenceManager();
    Query q = pm.newQuery( Post.class );
    q.setFilter(":p1.contains(blogKey)");
    q.setOrdering("timestamp desc");
    q.setRange(offset, offset + 11);
    List<Post> posts = (List<Post>)q.execute(getFollowedBlogs());

    // grab 11 to see if there are any more, then pop the last one
    boolean more = posts.size() > 10;
    if(more) posts = posts.subList( 0, 10 );

    return new PageList<Post>(posts, page, more);
  }

  public String getName()
  {
    return name;
  }

  public void setName(String name)
  {
    this.name = name;
  }

  public String getId()
  {
    return id;
  }

  public void setId(String id)
  {
    this.id = id;
  }

  public String getEmail()
  {
    return email;
  }

  public void setEmail(String email)
  {
    this.email = email;
  }
}

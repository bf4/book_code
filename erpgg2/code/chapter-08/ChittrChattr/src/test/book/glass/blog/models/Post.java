/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass.blog.models;

import java.util.Date;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

@PersistenceCapable
public class Post extends Base<Post>
{
  @PrimaryKey
  @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
  private Key key;
  
  private String blogKey;
  private String title;
  private String body;
  private Date timestamp;
  
  public Post( String blogKey, String title, String body, Date timestamp )
  {
    this.blogKey = blogKey;
    this.title = title;
    this.body = body;
    this.timestamp = timestamp;
  }

  public void setKey(Key key)
  {
    this.key = key;
  }
  
  public Key getKey()
  {
    return key;
  }
  
  public String getTitle()
  {
    return title;
  }
  
  public void setTitle(String title)
  {
    this.title = title;
  }
  
  public String getBody()
  {
    return body;
  }
  
  public void setBody(String body)
  {
    this.body = body;
  }
  
  public Date getTimestamp()
  {
    return timestamp;
  }
  
  public void setTimestamp(Date timestamp)
  {
    this.timestamp = timestamp;
  }

  public String getBlogKey()
  {
    return blogKey;
  }

  public void setBlogKey(String blogKey)
  {
    this.blogKey = blogKey;
  }
}

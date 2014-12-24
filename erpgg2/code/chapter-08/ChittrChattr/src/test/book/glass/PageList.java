/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass;

import java.util.List;

public class PageList<T>
{
  private List<T> list;
  private int current;
  private boolean more;

  public PageList( List<T> list, int current, boolean more) {
    this.list = list;
    this.current = current;
    this.more = more;
  }
  
  public List<T> getList()
  {
    return list;
  }
  public void setList(List<T> list)
  {
    this.list = list;
  }
  public int getCurrent()
  {
    return current;
  }
  public void setCurrent(int current)
  {
    this.current = current;
  }
  public boolean isMore()
  {
    return more;
  }
  public void setMore(boolean more)
  {
    this.more = more;
  }
}

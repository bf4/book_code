/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass.blog.models;

import test.book.glass.PMF;

public abstract class Base<T>
{
  @SuppressWarnings("unchecked")
  public T save()
  {
    return (T)PMF.save( this.getClass(), this );
  }
}

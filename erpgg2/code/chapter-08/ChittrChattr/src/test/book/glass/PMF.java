/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass;

import javax.jdo.JDOHelper;
import javax.jdo.PersistenceManager;
import javax.jdo.PersistenceManagerFactory;

public final class PMF
{
  private static final PersistenceManagerFactory INSTANCE =
      JDOHelper.getPersistenceManagerFactory("transactions-optional");
  
  private PMF() {}
  
  public static PersistenceManagerFactory get() {
    return INSTANCE;
  }

  @SuppressWarnings("unchecked")
  public static <T> T save( T c, Object o ) {
    PersistenceManager pm = get().getPersistenceManager();
    try {
      return (T)pm.makePersistent( o );
    } finally {
      pm.close();
    }
  }
}
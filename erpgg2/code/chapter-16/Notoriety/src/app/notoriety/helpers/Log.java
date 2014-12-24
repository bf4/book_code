/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package app.notoriety.helpers;

/**
 * A convenience logger that always logs to this package space.
 * @author ericredmond
 */
public class Log
{
  public static final String TAG = Log.class.getPackage().getName();

  public static final void d( String message ) {
    android.util.Log.d(TAG, message);
  }

  public static final void d( String message, Throwable t ) {
    android.util.Log.d(TAG, message, t);
  }

  public static final void d( String message, Object...args ) {
    android.util.Log.d(TAG, String.format(message, args));
  }

  public static final void i( String message ) {
    android.util.Log.i(TAG, message);
  }

  public static final void i( String message, Throwable t ) {
    android.util.Log.i(TAG, message, t);
  }

  public static final void i( String message, Object...args ) {
    android.util.Log.i(TAG, String.format(message, args));
  }

  public static final void w( String message ) {
    android.util.Log.w(TAG, message);
  }

  public static final void w( String message, Throwable t ) {
    android.util.Log.w(TAG, message, t);
  }

  public static final void w( String message, Object...args ) {
    android.util.Log.w(TAG, String.format(message, args));
  }

  public static final void e( String message ) {
    android.util.Log.e(TAG, message);
  }

  public static final void e( String message, Throwable t ) {
    android.util.Log.e(TAG, message, t);
  }

  public static final void e( String message, Object...args ) {
    android.util.Log.e(TAG, String.format(message, args));
  }

  public static final void v( String message ) {
    android.util.Log.v(TAG, message);
  }

  public static final void v( String message, Throwable t ) {
    android.util.Log.v(TAG, message, t);
  }

  public static final void v( String message, Object...args ) {
    android.util.Log.v(TAG, String.format(message, args));
  }

  public static final void wtf( String message ) {
    android.util.Log.wtf(TAG, message);
  }

  public static final void wtf( String message, Throwable t ) {
    android.util.Log.wtf(TAG, message, t);
  }

  public static final void wtf( String message, Object...args ) {
    android.util.Log.wtf(TAG, String.format(message, args));
  }
}
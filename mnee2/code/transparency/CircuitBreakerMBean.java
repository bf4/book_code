/***
 * Excerpted from "Release It! Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/mnee2 for more book information.
***/
package com.example.util;

import java.io.IOException;

public interface CircuitBreakerMBean {
	public void setResetTime(long timestamp) throws IOException;
	public long getResetTime() throws IOException;

	public CircuitBreakerState getState() throws IOException;
	
	public void reset() throws IOException;
}

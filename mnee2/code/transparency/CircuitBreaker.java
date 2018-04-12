/***
 * Excerpted from "Release It! Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/mnee2 for more book information.
***/
package com.example.util;

public class CircuitBreaker implements CircuitBreakerMBean {
	private CircuitBreakerState state = CircuitBreakerState.CLOSED;
	private long resetTime = -1;
	
	public void setResetTime(long timestamp) {
		this.resetTime = timestamp;
		checkForReset();
	}

	public long getResetTime() {
		return resetTime;
	}

	public CircuitBreakerState getState() {
		return state;
	}

	public void reset() {
		setState(CircuitBreakerState.CLOSED);
	}

	...
}

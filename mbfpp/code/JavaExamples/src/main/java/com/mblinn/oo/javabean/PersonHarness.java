/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.javabean;

public class PersonHarness {

	public static void main(String[] args) {
		ImmutablePerson.Builder b = ImmutablePerson.newBuilder();
		ImmutablePerson p = b.firstName("Peter").lastName("Jones").build();
	}
}

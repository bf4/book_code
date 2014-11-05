/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.nullobject;

class NullPerson implements Person {

	public String getFirstName() {
		return "John";
	}

	public void setFirstName(String firstName) {
	}

	public String getLastName() {
		return "Doe";
	}

	public void setLastName(String lastName) {
	}
}

/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.javabean;

public class ImmutablePerson {

	private final String firstName;
	private final String lastName;

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	private ImmutablePerson(Builder builder){
		firstName = builder.firstName;
		lastName = builder.lastName;
	}
	
	public static class Builder {
		private String firstName;
		private String lastName;

		public Builder firstName(String firstName) {
			this.firstName = firstName;
			return this;
		}

		public Builder lastName(String lastName) {
			this.lastName = lastName;
			return this;
		}

		public ImmutablePerson build() {
			return new ImmutablePerson(this);
		}
	}

	public static Builder newBuilder() {
		return new Builder();
	}
}

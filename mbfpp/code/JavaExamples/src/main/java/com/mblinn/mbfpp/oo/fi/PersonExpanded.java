/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.fi;

public class PersonExpanded implements Comparable<PersonExpanded> {
	private String firstName;
	private String lastName;
	private String midName;

	public PersonExpanded(String firstName, String midName, String lastName) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.midName = midName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getMidName() {
		return midName;
	}

	public void setMidName(String middleName) {
		this.midName = middleName;
	}

	@Override
	public int compareTo(PersonExpanded otherPerson) {
		return this.lastName.compareTo(otherPerson.lastName);
	}

	@Override
	public String toString() {
		return firstName + " " + midName + " " + lastName;
	}

}

/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.fi;

import java.util.Comparator;


public class Harness {

	public static void main(String[] args) {
		Comparator<PersonExpanded> firstAndLastNameComparator = 
				new ComposedComparator<PersonExpanded>(
						new FirstNameComparator(), 
						new LastNameComparator());

		PersonExpanded personOne = new PersonExpanded("John", "", "Adams");
		PersonExpanded personTwo = new PersonExpanded("John", "Quincy", "Adams");

		System.out
		    .println(firstAndLastNameComparator.compare(personOne, personTwo));
	}
}

class FirstNameComparator implements Comparator<PersonExpanded> {
	@Override
	public int compare(PersonExpanded personOne, PersonExpanded personTwo) {
		return personOne.getFirstName().compareTo(personTwo.getFirstName());
	}
}

class LastNameComparator implements Comparator<PersonExpanded> {
	@Override
	public int compare(PersonExpanded personOne, PersonExpanded personTwo) {
		return personOne.getLastName().compareTo(personTwo.getLastName());
	}
}

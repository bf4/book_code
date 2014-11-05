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


public class ComplicatedNameComparator implements Comparator<PersonExpanded> {
	public int compare(PersonExpanded p1, PersonExpanded p2) {

		int firstNameCompare = 
				p1.getFirstName().compareTo(p2.getFirstName());
		int lastNameCompare = p1.getLastName().compareTo(p2.getLastName());
		int middleNameCompare = p1.getMidName().compareTo(p2.getMidName());

		if (0 != firstNameCompare)
			return firstNameCompare;
		else if (0 != lastNameCompare)
			return lastNameCompare;
		else
			return middleNameCompare;
	}
}

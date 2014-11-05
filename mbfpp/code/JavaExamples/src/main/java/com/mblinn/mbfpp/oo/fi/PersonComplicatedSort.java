/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.fi;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


public class PersonComplicatedSort {

	public static void main(String[] args) {
		List<PersonExpanded> people = new ArrayList<PersonExpanded>();
		people.add(new PersonExpanded("Aaron", "Jeffrey", "Smith"));
		people.add(new PersonExpanded("Aaron", "Bailey", "Zanthar"));
		people.add(new PersonExpanded("Brian", "Adams", "Smith"));

		Collections.sort(people, new ComplicatedNameComparator());

		for (PersonExpanded person : people) {
			System.out.println(person);
		}
	}

}
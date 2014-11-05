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

public class PersonNaturalSort {

	public static void main(String[] args) {
		Person p1 = new Person("Mike", "Bevilacqua");
		Person p2 = new Person("Pedro", "Vasquez");
		Person p3 = new Person("Robert", "Aarons");

		List<Person> people = new ArrayList<Person>();
		people.add(p1);
		people.add(p2);
		people.add(p3);

		Collections.sort(people);

		for (Person person : people) {
			System.out.println(person);
		}
	}
}

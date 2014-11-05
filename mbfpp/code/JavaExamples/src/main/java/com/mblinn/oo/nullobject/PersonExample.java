/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.nullobject;

import java.util.HashMap;
import java.util.Map;

public class PersonExample {
	private Map<Integer, Person> people;

	public PersonExample() {
		people = new HashMap<Integer, Person>();
	}

	public Person fetchPerson(Integer id) {
		Person person = people.get(id);
		if (null != person)
			return person;
		else
			return new NullPerson();
	}
	// Code to add/remove people
	
	public Person buildPerson(String firstName, String lastName){
		if(null != firstName && null != lastName)
			return new RealPerson(firstName, lastName);
		else
			return new NullPerson();
	}
}

/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.strategy;

import java.util.ArrayList;
import java.util.List;

public class PersonCollector {
	private PersonValidator personValidator;
	private List<Person> validPeople;

	public PersonCollector(PersonValidator personValidator) {
		this.personValidator = personValidator;
		this.validPeople = new ArrayList<Person>();
	}

	public void addPerson(Person person) {
		if (personValidator.validate(person))
			validPeople.add(person);
	}

	public List<Person> getValidPeople() {
		return validPeople;
	}
}

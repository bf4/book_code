/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.strategy;

import static org.junit.Assert.assertEquals;

import org.junit.Before;
import org.junit.Test;

public class PersonCollectorTest {
	
	PersonCollector personCollector;
	
	@Before
	public void setup(){
		personCollector = new PersonCollector(new DummyValidator());
	}
	
	@Test
	public void personCollector_startsWithEmptyList(){
		assertEquals(0, personCollector.getValidPeople().size());
	}
	
	@Test
	public void personCollector_addsPeopleToList(){
		Person mike = new Person("Mike", "", "Bevilacqua");
		Person rollo = new Person("Rollo", "", "Tomassi");
		
		personCollector.addPerson(mike);
		personCollector.addPerson(rollo);
		
		assertEquals(2, personCollector.getValidPeople().size());
	}

}

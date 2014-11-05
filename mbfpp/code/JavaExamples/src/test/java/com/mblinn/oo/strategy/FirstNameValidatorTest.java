/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.strategy;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Test;

public class FirstNameValidatorTest {

	private FirstNameValidator firstNameValidator;
	
	@Before
	public void setup(){
		firstNameValidator = new FirstNameValidator();
	}
	
	@Test
	public void fullNameValidator_returnsTrueWhenFirstNameIsSet(){
		Person john = new Person("John", "Quincy", "Adams");
		assertTrue(firstNameValidator.validate(john));
		john = new Person("John", null, "Adams");
		assertTrue(firstNameValidator.validate(john));
		john = new Person("John", "Quincy", null);
		assertTrue(firstNameValidator.validate(john));

	}
	
	@Test
	public void fullNameValidator_returnsFalseWhenFirstNameNotSet(){
		Person john = new Person(null, "Quincy", "Adams");
		assertFalse(firstNameValidator.validate(john));
	}
}

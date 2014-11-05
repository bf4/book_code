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

public class FullNameValidatorTest {

	FullNameValidator fullNameValidator;
	
	@Before
	public void setup(){
		fullNameValidator = new FullNameValidator();
	}
	
	@Test
	public void fullNameValidator_returnsTrueWhenAllNamesAreSet(){
		Person john = new Person("John", "Quincy", "Adams");
		assertTrue(fullNameValidator.validate(john));
	}
	
	@Test
	public void fullNameValidator_returnsFalseWhenAnyNameNotSet(){
		Person john = new Person("John", null, "Adams");
		assertFalse(fullNameValidator.validate(john));
		john = new Person(null, "Quincy", "Adams");
		assertFalse(fullNameValidator.validate(john));
		john = new Person("John", "Quincy", null);
		assertFalse(fullNameValidator.validate(john));
	}
}

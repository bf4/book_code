/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.fi;

import static org.junit.Assert.assertEquals;

import org.junit.Before;
import org.junit.Test;


public class PersonExpandedTest {

	ComplicatedNameComparator complicatedNameComparator;
	
	@Before
	public void setup(){
		complicatedNameComparator = new ComplicatedNameComparator();
	}
	
	@Test
	public void complicatedNameComparator_sortsByFirstNameFirst(){
		PersonExpanded p1 = new PersonExpanded("a", "c", "d");
		PersonExpanded p2 = new PersonExpanded("b", "c", "d");
		assertEquals(-1, complicatedNameComparator.compare(p1,  p2));
	}
	
	@Test
	public void complicatedNameComparator_sortsByLastNameSecond(){
		PersonExpanded p1 = new PersonExpanded("a", "c", "b");
		PersonExpanded p2 = new PersonExpanded("a", "c", "d");
		assertEquals(-2, complicatedNameComparator.compare(p1,  p2));
	}
	
	@Test
	public void complicatedNameComparator_sortsByMiddleNameThird(){
		PersonExpanded p1 = new PersonExpanded("a", "b", "d");
		PersonExpanded p2 = new PersonExpanded("a", "c", "d");
		assertEquals(-1, complicatedNameComparator.compare(p1,  p2));
	}
}

/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.command;

import static org.junit.Assert.assertEquals;

import org.junit.Before;
import org.junit.Test;

import com.mblinn.mbfpp.oo.command.CashRegister;

public class CashRegisterTests {

	private CashRegister cashRegisterUnderTest;
	
	@Before
	public void setup(){
		cashRegisterUnderTest = new CashRegister(0);
	}
	
	@Test
	public void addingMoneyToRegister_addsItToTotal(){
		cashRegisterUnderTest.addCash(100);
		assertEquals(Integer.valueOf(100), cashRegisterUnderTest.getTotal());
		cashRegisterUnderTest.addCash(50);
		assertEquals(Integer.valueOf(150), cashRegisterUnderTest.getTotal());
	}
	
}

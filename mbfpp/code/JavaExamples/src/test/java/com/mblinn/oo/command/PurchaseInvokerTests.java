/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.command;

import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Test;

import com.mblinn.mbfpp.oo.command.PurchaseInvoker;

public class PurchaseInvokerTests {

	private PurchaseInvoker purchaseInvokerUnderTest;
	
	private RecordingStubCommand testCommand;
	
	@Before
	public void setUp(){
		purchaseInvokerUnderTest = new PurchaseInvoker();
		testCommand = new RecordingStubCommand();
	}
	
	@Test
	public void executingAPurchase_ShouldExecuteTheUnderlyingCommand(){
		purchaseInvokerUnderTest.executePurchase(testCommand);
		assertTrue(testCommand.wasExecuted);
	}
	
	@Test
	public void executingAPurchase_ShouldAddTheCommandToHistory(){
		purchaseInvokerUnderTest.executePurchase(testCommand);
		assertTrue(testCommand == purchaseInvokerUnderTest.getPurchaseHistory().get(0));
	}
	
}

/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.command;

public class Purchase implements Command {
	private CashRegister cashRegister;
	private Integer amount;

	public Purchase(CashRegister cashRegister, Integer amount) {
		this.cashRegister = cashRegister;
		this.amount = amount;
	}

	@Override
	public void execute() {
		cashRegister.addCash(amount);
	}

}

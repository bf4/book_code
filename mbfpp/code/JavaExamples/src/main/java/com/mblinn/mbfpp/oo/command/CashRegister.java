/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.command;

public class CashRegister {
	private Integer total;

	public CashRegister(Integer startingTotal) {
		total = startingTotal;
	}

	public void addCash(Integer toAdd) {
		total += toAdd;
	}

	public Integer getTotal() {
		return total;
	}

	public void reset() {
		total = 0;
	}
}

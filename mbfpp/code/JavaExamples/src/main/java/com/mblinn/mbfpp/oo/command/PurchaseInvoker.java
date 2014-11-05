/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.command;

import java.util.ArrayList;
import java.util.List;

public class PurchaseInvoker {
	private List<Command> executedPurchases = new ArrayList<Command>();

	public void executePurchase(Command purchase) {
		purchase.execute();
		executedPurchases.add(purchase);
	}

	public List<Command> getPurchaseHistory() {
		return executedPurchases;
	}
}

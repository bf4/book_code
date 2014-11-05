/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.command;

import java.util.List;

public class RegisterClient {
	private static CashRegister cashRegister = new CashRegister(0);
	private static PurchaseInvoker purchaseInvoker = new PurchaseInvoker();

	public static void main(String[] args) {
		Command purchase1 = new Purchase(cashRegister, 100);
		Command purchase2 = new Purchase(cashRegister, 50);

		// Invoke commands, check register total.
		purchaseInvoker.executePurchase(purchase1);
		purchaseInvoker.executePurchase(purchase2);
		System.out.println("After purchases: " + cashRegister.getTotal());

		// Replay purchases
		cashRegister.reset();
		System.out.println("Register reset to 0");
		List<Command> purchases = purchaseInvoker.getPurchaseHistory();
		for (Command purchase : purchases) {
			purchase.execute();
		}
		System.out.println("After replay: " + cashRegister.getTotal());
	}
}

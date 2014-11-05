/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.functional.tailrecursion;

public class Sum {

	public static void main(String[] args) {
		System.out.println("sum: " + sum(10));
		System.out.println("sumRecursive: " + sumRecursive(10));
		System.out.println("sumTailRecursive: " + sumTailRecursive(10, 0));
	}

	public static int sum(int upTo) {
		int sum = 0;
		for (int i = 0; i <= upTo; i++)
			sum += i;
		return sum;
	}


	public static int sumRecursive(int upTo) {
		if (upTo == 0)
			return 0;
		else
			return upTo + sumRecursive(upTo - 1);
	}


	public static int sumTailRecursive(int upTo, int currentSum) {
		if (upTo == 0)
			return currentSum;
		else
			return sumTailRecursive(upTo - 1, currentSum + upTo);
	}
}

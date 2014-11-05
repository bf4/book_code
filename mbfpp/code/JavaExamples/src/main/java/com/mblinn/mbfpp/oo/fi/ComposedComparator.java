/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.fi;

import java.util.Comparator;

public class ComposedComparator<T> implements Comparator<T> {

	private Comparator<T>[] comparators;

	public ComposedComparator(Comparator<T>... comparators) {
		this.comparators = comparators;
	}

	@Override
	public int compare(T o1, T o2) {
		for (Comparator<T> comparator : comparators) {
			int result = comparator.compare(o1, o2);
			if (result != 0)
				return result;
		}
		return 0;
	}

}

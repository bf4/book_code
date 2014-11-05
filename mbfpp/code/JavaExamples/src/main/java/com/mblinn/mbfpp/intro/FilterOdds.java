/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.intro;

import java.util.ArrayList;
import java.util.List;

public class FilterOdds {

	public List<Integer> filterOdds(List<Integer> list) {
		List<Integer> filteredList = new ArrayList<Integer>();
		for (Integer current : list) {
			if (isOdd(current)) {
				filteredList.add(current);
			}
		}
		return filteredList;
	}
	private boolean isOdd(Integer integer) {
		return 0 != integer % 2;
	}
}

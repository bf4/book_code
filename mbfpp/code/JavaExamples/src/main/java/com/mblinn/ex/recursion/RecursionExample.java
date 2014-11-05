/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.ex.recursion;

import java.util.ArrayList;
import java.util.List;

public class RecursionExample {

	public static void main(String[] args) {
		List<Integer> list = new ArrayList<Integer>();
		list.add(1);
		list.add(2);
		list.add(3);
		System.out.println(addList(list));
	}


	public static Integer addList(List<Integer> list) {
		// if the list is only one element long, return that element.
		if (list.size() == 1) {
			return list.get(0);
		}
		// otherwise, return the result of adding the first item in the list,
		// to the rest of the list added together
		else {
			Integer first = list.get(0);
			List<Integer> rest = list.subList(1, list.size());
			return first + addList(rest);
		}
	}
}

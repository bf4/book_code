/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.functional.coo;

import java.util.ArrayList;
import java.util.List;

public class Examples {

	public static void main(String[] args){
		List<String> names = new ArrayList<String>();
		names.add("Michael Bevilacqua Linn");
		names.get(0).toUpperCase();
	}
}

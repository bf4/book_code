/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.ex.repeating;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

public class VowelFilter {
	private static final Set<Character> vowels = new HashSet<Character>();
	static {
		vowels.add('a');
		vowels.add('e');
		vowels.add('i');
		vowels.add('o');
		vowels.add('u');
	}

	public Collection<Character> vowelsInWord(String word) {
		Set<Character> vowelsInString = new HashSet<Character>();

		for (Character character : word.toLowerCase().toCharArray()) {
			if (vowels.contains(character)) {
				vowelsInString.add(character);
			}
		}

		return vowelsInString;
	}
}

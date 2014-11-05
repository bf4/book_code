/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.iterator;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class HigherOrderFunctions {

	public static Integer sumSequence(List<Integer> sequence) {
		Integer sum = 0;
		for (Integer num : sequence) {
			sum += num;
		}
		return sum;
	}


	public static List<String> prependHello(List<String> names) {
		List<String> prepended = new ArrayList<String>();
		for (String name : names) {
			prepended.add("Hello, " + name);
		}
		return prepended;
	}


	public static Set<Character> vowelsInWord(String word) {
	
		Set<Character> vowelsInWord = new HashSet<Character>();
		
		for (Character character : word.toLowerCase().toCharArray()) {
			if (isVowel(character)) {
				vowelsInWord.add(character);
			}
		}
		
		return vowelsInWord;
	}

	private static Boolean isVowel(Character c){
		Set<Character> vowels = new HashSet<Character>();
		vowels.add('a');
		vowels.add('e');
		vowels.add('i');
		vowels.add('o');
		vowels.add('u');
		return vowels.contains(c);
	}
}

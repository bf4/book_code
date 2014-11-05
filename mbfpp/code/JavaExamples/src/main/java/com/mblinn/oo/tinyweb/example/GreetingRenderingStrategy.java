/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.tinyweb.example;

import java.util.List;
import java.util.Map;

import com.mblinn.oo.tinyweb.RenderingStrategy;

public class GreetingRenderingStrategy implements RenderingStrategy {

	@Override
	public String renderView(Map<String, List<String>> model) {
		List<String> greetings = model.get("greetings");
		StringBuffer responseBody = new StringBuffer();
		responseBody.append("<h1>Friendly Greetings:</h1>\n");
		for (String greeting : greetings) {
			responseBody.append(
					String.format("<h2>%s</h2>\n", greeting));

		}
		return responseBody.toString();
	}

}

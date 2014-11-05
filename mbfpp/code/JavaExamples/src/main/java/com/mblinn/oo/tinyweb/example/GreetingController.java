/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.tinyweb.example;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.mblinn.oo.tinyweb.HttpRequest;
import com.mblinn.oo.tinyweb.TemplateController;
import com.mblinn.oo.tinyweb.View;

public class GreetingController extends TemplateController {
	private Random random;
	public GreetingController(View view) {
		super(view);
		random = new Random();
	}

	@Override
	public Map<String, List<String>> doRequest(HttpRequest httpRequest) {
		Map<String, List<String>> helloModel = 
				new HashMap<String, List<String>>();
		helloModel.put("greetings", 
				generateGreetings(httpRequest.getBody()));
		return helloModel;
	}

	private List<String> generateGreetings(String namesCommaSeparated) {
		String[] names = namesCommaSeparated.split(",");
		List<String> greetings = new ArrayList<String>();
		for (String name : names) {
			greetings.add(makeGreeting(name));
		}
		return greetings;
	}

	private String makeGreeting(String name) {
		String[] greetings = 
			{ "Hello", "Greetings", "Salutations", "Hola" };
		String greetingPrefix = greetings[random.nextInt(4)];
		return String.format("%s, %s", greetingPrefix, name);
	}
}

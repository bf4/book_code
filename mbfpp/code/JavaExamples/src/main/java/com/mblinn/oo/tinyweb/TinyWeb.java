/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.tinyweb;

import java.util.List;
import java.util.Map;

public class TinyWeb {
	private Map<String, Controller> controllers;
	private List<Filter> filters;

	public TinyWeb(Map<String, Controller> controllers, List<Filter> filters) {
		this.controllers = controllers;
		this.filters = filters;
	}

	public HttpResponse handleRequest(HttpRequest httpRequest) {

		HttpRequest currentRequest = httpRequest;
		for (Filter filter : filters) {
			currentRequest = filter.doFilter(currentRequest);
		}

		Controller controller = controllers.get(currentRequest.getPath());

		if (null == controller)
			return null;

		return controller.handleRequest(currentRequest);
	}
}

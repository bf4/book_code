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

public abstract class TemplateController implements Controller {
	private View view;
	public TemplateController(View view) {
		this.view = view;
	}

	public HttpResponse handleRequest(HttpRequest request) {
		Integer responseCode = 200;
		String responseBody = "";

		try {
			Map<String, List<String>> model = doRequest(request);
			responseBody = view.render(model);
		} catch (ControllerException e) {
			responseCode = e.getStatusCode();
		} catch (RenderingException e) {
			responseCode = 500;
			responseBody = "Exception while rendering.";
		} catch (Exception e) {
			responseCode = 500;
		}

		return HttpResponse.Builder.newBuilder().body(responseBody)
		    .responseCode(responseCode).build();
	}
	protected abstract Map<String, List<String>> doRequest(HttpRequest request);
}

/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.tinyweb;

import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.mblinn.mbfpp.oo.tinyweb.stubs.AddDummyHeaderFilter;
import com.mblinn.mbfpp.oo.tinyweb.stubs.DummyController;
import com.mblinn.mbfpp.oo.tinyweb.stubs.DummyViewRenderer;
import com.mblinn.oo.tinyweb.StrategyView;
import com.mblinn.oo.tinyweb.Controller;
import com.mblinn.oo.tinyweb.Filter;
import com.mblinn.oo.tinyweb.HttpRequest;
import com.mblinn.oo.tinyweb.HttpResponse;
import com.mblinn.oo.tinyweb.TinyWeb;

public class ITestTinyweb {

	TinyWeb tinyWeb;
	
	@Before
	public void setup(){
		DummyViewRenderer viewRenderer = new DummyViewRenderer();
		StrategyView greetingView = new StrategyView(viewRenderer);
		DummyController dummyController = new DummyController(greetingView);
		
		Map<String, Controller> controllers = new HashMap<String, Controller>();
		controllers.put("dummy/", dummyController);
		
		List<Filter> filters = new ArrayList<Filter>();
		filters.add(new AddDummyHeaderFilter());
		
		tinyWeb = new TinyWeb(controllers, filters);
	}
	
	@Test
	public void endToEnd(){
		HttpRequest request = HttpRequest.Builder.newBuilder().path("dummy/").build();
		HttpResponse response = tinyWeb.handleRequest(request);
		assertEquals(Integer.valueOf(200), response.getResponseCode());
		assertEquals("dummyModelValue", response.getBody());
	}
}

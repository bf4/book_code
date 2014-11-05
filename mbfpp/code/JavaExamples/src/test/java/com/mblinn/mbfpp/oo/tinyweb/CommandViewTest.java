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

import com.mblinn.mbfpp.oo.tinyweb.stubs.DummyViewRenderer;
import com.mblinn.mbfpp.oo.tinyweb.stubs.ExceptionalViewRenderer;
import com.mblinn.oo.tinyweb.StrategyView;
import com.mblinn.oo.tinyweb.RenderingException;
import com.mblinn.oo.tinyweb.RenderingStrategy;

public class CommandViewTest {

	RenderingStrategy dummyViewRenderer;
	RenderingStrategy exceptionalViewRenderer;
	StrategyView commandView;
	Map<String, List<String>> model;
	
	@Before
	public void setup(){
		dummyViewRenderer = new DummyViewRenderer();
		exceptionalViewRenderer = new ExceptionalViewRenderer();
		model = new HashMap<String, List<String>>();
		List<String> modelValues = new ArrayList<String>();
		modelValues.add("dummyModelValue");
		model.put("dummyModelKey", modelValues);
	}
	
	@Test
	public void commandView_rendersUsingViewRenderer(){
		commandView = new StrategyView(dummyViewRenderer);
		String body = commandView.render(model);
		assertEquals("dummyModelValue", body);
	}
	
	@Test(expected=RenderingException.class)
	public void commandView_catchesExceptionsAndWrapsThem(){
		commandView = new StrategyView(exceptionalViewRenderer);
		commandView.render(model);
	}
}

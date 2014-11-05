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

public class StrategyView implements View {

	private RenderingStrategy viewRenderer;

	public StrategyView(RenderingStrategy viewRenderer) {
		this.viewRenderer = viewRenderer;
	}

	@Override
	public String render(Map<String, List<String>> model) {
		try {
			return viewRenderer.renderView(model);
		} catch (Exception e) {
			throw new RenderingException(e);
		}
	}
}

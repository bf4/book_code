/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.tinyweb.stubs;

import java.util.List;
import java.util.Map;

import com.mblinn.oo.tinyweb.RenderingException;
import com.mblinn.oo.tinyweb.View;

public class ExceptionalView implements View {

	@Override
  public String render(Map<String, List<String>> model) {
		throw new RenderingException(new RuntimeException());
  }

}

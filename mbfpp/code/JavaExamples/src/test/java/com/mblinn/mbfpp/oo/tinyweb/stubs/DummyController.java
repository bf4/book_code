/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.tinyweb.stubs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mblinn.oo.tinyweb.HttpRequest;
import com.mblinn.oo.tinyweb.TemplateController;
import com.mblinn.oo.tinyweb.View;

public class DummyController extends TemplateController {

	public DummyController(View view) {
	  super(view);
  }
	
	@Override
  protected Map<String, List<String>> doRequest(HttpRequest request) {
		Map<String, List<String>> dummyMap = new HashMap<String, List<String>>();
		List<String> value = new ArrayList<String>();
		value.add("dummyModelValue");
		dummyMap.put("dummyModelKey", value);
		return dummyMap;
  }

}

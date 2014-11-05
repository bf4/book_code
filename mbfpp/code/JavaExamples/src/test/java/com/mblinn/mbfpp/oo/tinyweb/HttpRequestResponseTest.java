/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.tinyweb;

import static org.junit.Assert.*;

import org.junit.Test;

import com.mblinn.oo.tinyweb.HttpRequest;
import com.mblinn.oo.tinyweb.HttpResponse;

public class HttpRequestResponseTest {

	@Test
	public void whenBuildIsCalled_HttpResponseIsCreated() {
		HttpResponse httpResponse = HttpResponse.Builder.newBuilder().body("body")
		    .responseCode(200).build();
		assertEquals("body", httpResponse.getBody());
		assertEquals(Integer.valueOf(200), httpResponse.getResponseCode());
	}

	@Test
	public void whenBuildIsCalled_HttpRequestIsCreated() {
		HttpRequest httpRequest = HttpRequest.Builder.newBuilder().body("body")
		    .path("foo").addHeader("foo", "bar").build();
		assertEquals("body", httpRequest.getBody());
		assertEquals("foo", httpRequest.getPath());
		assertEquals("bar", httpRequest.getHeaders().get("foo"));
	}

	@Test
	public void whenBuilderFromIsCalled_builderStartsWithPassedInRequest() {
		HttpRequest httpRequest = HttpRequest.Builder.newBuilder().body("body")
		    .path("foo").addHeader("foo", "bar").build();
		HttpRequest httpRequest2 = HttpRequest.Builder.builderFrom(httpRequest).addHeader("baz", "quz").build();
		
		assertEquals("body", httpRequest2.getBody());
		assertEquals("foo", httpRequest2.getPath());
		assertEquals("bar", httpRequest2.getHeaders().get("foo"));
		assertEquals("quz", httpRequest2.getHeaders().get("baz"));
	}
}

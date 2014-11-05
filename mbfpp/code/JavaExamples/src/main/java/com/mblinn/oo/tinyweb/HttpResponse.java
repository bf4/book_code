/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.tinyweb;

public class HttpResponse {
	private final String body;
	private final Integer responseCode;

	public String getBody() {
		return body;
	}

	public Integer getResponseCode() {
		return responseCode;
	}

	private HttpResponse(Builder builder) {
		body = builder.body;
		responseCode = builder.responseCode;
	}

	public static class Builder {
		private String body;
		private Integer responseCode;

		public Builder body(String body) {
			this.body = body;
			return this;
		}

		public Builder responseCode(Integer responseCode) {
			this.responseCode = responseCode;
			return this;
		}

		public HttpResponse build() {
			return new HttpResponse(this);
		}

		public static Builder newBuilder() {
			return new Builder();
		}
	}
}

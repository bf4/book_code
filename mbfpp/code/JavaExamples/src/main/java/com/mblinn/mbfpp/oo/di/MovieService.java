/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.di;
public class MovieService {

	private MovieDao movieDao;
	private FavoritesService favoritesService;
	public MovieService(MovieDao movieDao, FavoritesService favoritesService){
		this.movieDao = movieDao;
		this.favoritesService = favoritesService;
	}
}

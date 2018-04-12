/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import store from './store';
import { requestMovies } from './movieApi';
import { MOVIES_LOADED } from './actions';
import MovieList from './MovieList';
import Filter from './Filter';

requestMovies().then(movies => store.dispatch({ type: MOVIES_LOADED, movies }));
const movieLists = ['Monday', 'Tuesday'].map(date =>
  <MovieList key={date} date={date} />
);
ReactDOM.render(
  <Provider store={store}>
    <main className="ph6 pv4">
      <h1 className="mt0">Programme</h1>
      <Filter name="filter" id="filter" label="Just favorites" />
      <div className="flex flex-row">
        {movieLists}
      </div>
    </main>
  </Provider>,
  document.getElementById('app')
);

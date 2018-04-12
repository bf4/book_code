/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import { combineReducers } from 'redux';
import {
  FILTER_CHANGED,
  MOVIES_LOADED,
  FAVORITED,
  UNFAVORITED
} from './actions';

export function filter(state = false, action) {
  switch (action.type) {
    case FILTER_CHANGED:
      return action.filter;
    default:
      return state;
  }
}

export function movies(state = [], action) {
  switch (action.type) {
    case MOVIES_LOADED:
      return action.movies;
    default:
      return state;
  }
}

export function favorites(state = [], action) {
  switch (action.type) {
    case FAVORITED:
      return [...state, action.movieId];
    case UNFAVORITED:
      return state.filter(id => id !== action.movieId);
    default:
      return state;
  }
}
export function loading(state = true, action) {
  switch (action.type) {
    case MOVIES_LOADED:
      return false;
    default:
      return state;
  }
}

export function isMovieFavorited(state, title) {
  return state.favorites.includes(title);
}
export default combineReducers({ movies, filter, favorites, loading });

/***
 * Excerpted from "Programming Elm",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/jfelm for more book information.
***/
import './main.css';
import { Main } from './Main.elm';

const date = new Date();

Main.embed(document.getElementById('root'), {
  year: date.getFullYear(),
  month: date.getMonth() + 1,
  day: date.getDate(),
});

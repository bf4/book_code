/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import React from 'react';
import { shallow } from 'enzyme';
import WordCounter from '../WordCounter';
import countWords from '../countWords';
import Counter from '../Counter';
import Editor from '../Editor';
import ProgressBar from '../ProgressBar';

describe('When I type some words', () => {
  const target = 10;
  const inputString = 'One two three four';
  const wordCounter = shallow(<WordCounter targetWordCount={target} />);
  const textarea = wordCounter.find(Editor).dive().find('textarea');
  textarea.simulate('change', { target: { value: inputString } });

  it('displays the correct count as a number', () => {
    const counter = wordCounter.find(Counter);
    expect(counter.prop('count')).toBe(countWords(inputString));
  });
  it('displays the correct progress', () => {
    const progressBar = wordCounter.find(ProgressBar);
    expect(progressBar.prop('completion')).toBe(
      countWords(inputString) / target
    );
  });
});

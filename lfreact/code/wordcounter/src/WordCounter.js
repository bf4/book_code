/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import React from 'react';
import ProgressBar from './ProgressBar';
import Counter from './Counter';
import Editor from './Editor';
import SaveManager from './SaveManager';
import countWords from './countWords';
import makeFakeRequest from './makeFakeRequest';


class WordCounter extends React.Component {
  constructor() {
    super();
    this.state = { text: '' };
    this.handleTextChange = this.handleTextChange.bind(this);
  }

  handleTextChange(currentText) {
    this.setState(() => ({ text: currentText }));
  }
  render() {
    const { targetWordCount } = this.props;
    const { text } = this.state;
    const wordCount = countWords(text);
    const progress = wordCount / targetWordCount;

    return (
      <form className="measure pa4 sans-serif">
        <Editor
          onTextChange={this.handleTextChange}
          text={text}
        />
        <Counter count={wordCount} />
        <ProgressBar completion={progress} />
        <SaveManager saveFunction={makeFakeRequest} data={this.state} />
      </form>
    );
  }
}

export default WordCounter;

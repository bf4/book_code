/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import React from 'react';
import Pikaday from 'pikaday';

class DatePicker extends React.Component {
  componentDidMount() {
    const el = this.el;
    const { onSelect } = this.props;
    this.picker = new Pikaday({
      field: el,
      onSelect
    });
  }

  componentWillUnmount() {
    this.picker.destroy();
  }

  render() {
    return (
      <input
        ref={input => {
          this.el = input;
        }}
      />
    );
  }
}

export default DatePicker;

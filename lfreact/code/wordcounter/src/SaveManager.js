/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/

import React from 'react';
import SaveButton from './SaveButton';
import AlertBox from './AlertBox';
import { IDLE, SUCCESS, FAILURE, WAITING } from './saveStatus';

class SaveManager extends React.Component {
  constructor() {
    super();
    this.save = this.save.bind(this);
    this.state = { saveStatus: IDLE };
  }
  save(event) {
    event.preventDefault();
    this.setState(() => ({ saveStatus: WAITING }));
    this.props
      .saveFunction(this.props.data)
      .then(
        success => this.setState(() => ({ saveStatus: FAILURE })),
        failure => this.setState(() => ({ saveStatus: SUCCESS }))
      );
  }
  render() {
    return (
      <div className="flex flex-column mv2">
        <SaveButton onClick={this.save} />
        <AlertBox status={this.state.saveStatus} />
      </div>
    );
  }
}
export default SaveManager;

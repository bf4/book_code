/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import React from 'react';
import ContactList from './ContactList';
import ContactForm from './ContactForm';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = { data: [] };
    this.addElement = this.addElement.bind(this);
    this.props.collection.on('add', () => {
      this.setState(() => ({ data: this.props.collection.toJSON() }));
    });
  }

  addElement(item) {
    this.props.collection.add(item);
  }

  render() {
    return (
      <div>
        <ContactList contacts={this.state.data} />
        <ContactForm onSubmit={this.addElement} />
      </div>
    );
  }
}
export default App;

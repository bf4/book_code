/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import React from 'react';
import TextInput from './TextInput';

class ContactForm extends React.Component {
  constructor() {
    super();
    this.form = {};
    this.save = this.save.bind(this);
  }

  save() {
    this.props.onSubmit(this.form);
  }

  update(key) {
    return function(event) {
      this.form[key] = event.target.value;
    }.bind(this);
  }

  render() {
    return (
      <form>
        <h2>Add contact</h2>
        <TextInput label="Name" changed={this.update('name')} />
        <TextInput label="Address" changed={this.update('address')} />
        <TextInput label="ZIP" changed={this.update('zip')} />
        <TextInput label="Email" changed={this.update('email')} />
        <button type="button" onClick={this.save}>Save</button>
      </form>
    );
  }
}

export default ContactForm;

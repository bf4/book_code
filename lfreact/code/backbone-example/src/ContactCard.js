/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
import React from 'react';

function ContactCard({ contact }) {
  return (
    <dl>
      <dt>Name</dt>
      <dd>{contact.name}</dd>
      <dt>Address</dt>
      <dd>{contact.address}</dd>
      <dt>Post code/ ZIP code</dt>
      <dd>{contact.zip}</dd>
    </dl>
  );
}

export default ContactCard;

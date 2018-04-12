/***
 * Excerpted from "Programming Elm",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/jfelm for more book information.
***/
import React, { Component } from 'react';
import Elm from './ImageUpload.elm';
import './ImageUpload.css';

class ImageUpload extends Component {
  constructor(props) {
    super(props);
    this.setElmRef = this.setElmRef.bind(this);
  }

  componentDidMount() {
    this.elm = Elm.ImageUpload.embed(this.elmRef);
  }

  setElmRef(node) {
    this.elmRef = node;
  }

  render() {
    return <div ref={this.setElmRef} />;
  }
}

export default ImageUpload;

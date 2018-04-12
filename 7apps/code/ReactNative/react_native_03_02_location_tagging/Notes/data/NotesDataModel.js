/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
'use strict';

const EventEmitter = require('EventEmitter');
const ListView = require('ListView');
const Platform = require('Platform');

class NotesDataModel extends EventEmitter {

  notes:Array<Object> = [];

  constructor() {
    super();
    // Notes for testing
    /*
    for (let i = 1; i<=20; i++) {
      this.notes.push({title:`Note ${i}`, body:`This is a test note\n
This is line two\n
This is line three`});
    }
    */
  }

  notesEndpoint():string {
    // Use this for emulator
    // String url = "http://10.0.2.2:3000/notes";
    // Use this for genymotion
    // String url = "http://10.0.3.2:3000/notes";
    if (Platform.OS === 'android') {
      return "http://10.0.2.2:3000/notes";
    } else {
      return "http://localhost:3000/notes";
    }
  }

  fetchAllNotes():void {
    fetch(this.notesEndpoint(),{
      headers: {
        'Accept': 'application/json',
      }
    })
      .then((response) => response.json())
      .then((responseData) => {
        this.notes = responseData;
        this.emit('noteRowsUpdated', {model: this});
      })
      .done();
  }

  newDataSourceFromRows():ListView.DataSource {
    let ds = new ListView.DataSource(
      {rowHasChanged: (r1, r2) => r1 !== r2}
    );
    return ds.cloneWithRows(this.notes);
  }

  createNewNote(title:String, body:String):void {
    fetch(this.notesEndpoint(),{
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: JSON.stringify({title:title, body:body}),
    })
      .then((response) => response.json())
      .then((note) => {
        console.log(note);
        this.notes.push(note);
        this.emit('noteRowsUpdated', {model: this});
      })
      .done();
  }
}

module.exports = NotesDataModel;

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

class NotesDataModel extends EventEmitter {

  notes:Array<Object> = [];

  newDataSourceFromRows():ListView.DataSource {
    let ds = new ListView.DataSource(
      {rowHasChanged: (r1, r2) => r1 !== r2}
    );
    return ds.cloneWithRows(this.notes);
  }

  createNewNote(title:String, body:String):void {
    this.notes.push({title: title, body: body});
    this.emit('noteRowsUpdated', {model: this});
  }
}

module.exports = NotesDataModel;

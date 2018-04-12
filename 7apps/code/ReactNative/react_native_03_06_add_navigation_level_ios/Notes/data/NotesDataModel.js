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
  getLocationTimeoutMax:number = 2;
  getLocationTimeoutAttempts:number = 0;

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

  host():string {
    // Use this for emulator
    // String url = "http://10.0.2.2:3000";
    // Use this for genymotion
    // String url = "http://10.0.3.2:3000";
    if (Platform.OS === 'android') {
      return "http://10.0.2.2:3000";
    } else {
      return "http://localhost:3000";
    }
  }

  notesEndpoint():string {
    return `${this.host()}/notes`;
  }

  reverseGeocodeEndpoint(latitude, longitude):string {
    return `${this.host()}/reverse_geocode?lat=${latitude}&long=${longitude}`;
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

  getLocation() {
    this.getLocationTimeoutAttempts = 1;
    navigator.geolocation.getCurrentPosition(
      (position) => {
        this.locationLoaded(position);
      },
      (error) => {
        if (error.code === error.TIMEOUT &&
            this.getLocationTimeoutAttempts <
            this.getLocationTimeoutMax) {
          this.getLocation();
        } else {
          alert(error.message)
        }
      },
      {enableHighAccuracy: true, timeout: 2000, maximumAge: 1000}
    );
  }

  locationLoaded(position) {
    this.reverseGeocode(position.coords.latitude,
                        position.coords.longitude);
  }

  reverseGeocode(latitude, longitude):void {
    fetch(this.reverseGeocodeEndpoint(latitude, longitude),{
      headers: {
        'Accept': 'application/json',
      }
    })
      .then((response) => response.json())
      .then((placeData) => {
        let placeName = placeData.place;
        this.emit('placeLoaded', {
          place: placeName,
          latitude: latitude,
          longitude: longitude,
        });
      })
      .done();
  }

  newDataSourceFromRows():ListView.DataSource {
    let ds = new ListView.DataSource(
      {rowHasChanged: (r1, r2) => r1 !== r2}
    );
    return ds.cloneWithRows(this.notes);
  }

  createNewNote(title:String, body:String, place:Object):void {
    let params = {title:title, body:body};
    if (place != null) {
      params.created_where = place.place;
      params.latitude = place.latitude;
      params.longitude = place.longitude;
    }
    fetch(this.notesEndpoint(),{
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: JSON.stringify(params),
    })
      .then((response) => response.json())
      .then((note) => {
        this.notes.push(note);
        this.emit('noteRowsUpdated', {model: this});
      })
      .done();
  }
}

module.exports = NotesDataModel;

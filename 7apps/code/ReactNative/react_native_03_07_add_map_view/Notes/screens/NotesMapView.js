/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
'use strict';

import React, {
  View,
  Component,
  MapView,
} from 'react-native';

import styles from '../styles';

class NotesMapView extends Component {

  render() {
    return (
      <View style={styles.container}>
        <MapView
          style={{flex:1}}
          annotations={this.props.noteDataModel.mapAnnotations()}
        />
      </View>
    );
  }

}

module.exports = NotesMapView;

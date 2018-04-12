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
  Text,
  Component,
} from 'react-native';

import styles from '../../styles';

class NoteCell extends Component {

  render() {
    var bodyCharLimit = 140;
    var bodyChars = bodyCharLimit - 3;
    var body = this.props.note.body;
    return(
      <View>
        <Text style={styles.noteCellTitle}>
          {this.props.note.title}
        </Text>
        <Text style={styles.noteCellBody}
          numberOfLines={2}>{
          (body.length > bodyCharLimit) ?
          (body.substring(0, bodyChars) + "...") :
           body
        }</Text>
        <View style={styles.divider} />
      </View>
    );
  }

}

module.exports = NoteCell;

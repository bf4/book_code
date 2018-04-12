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
  AppRegistry,
  View,
  TextInput,
  Component,
} from 'react-native';

import styles from '../styles';

class NewNote extends Component {
  render() {
    return (
      <View style={styles.container}>
        <TextInput
          placeholder="Note Title"
          style={[styles.noteTextInput, styles.titleTextInput]} />
        <View style={styles.divider} />
        <TextInput
          placeholder="Enter a note..."
          multiline={true}
          textAlignVertical='top'
          style={[styles.noteTextInput, styles.noteBodyTextInput]} />
      </View>
    );
  }
}

module.exports = NewNote;

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
  StyleSheet,
  View,
  Text,
  Component,
} from 'react-native';

class MainScreen extends Component {

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.instructions}>
          Create a note.
        </Text>
      </View>
    );
  }
};

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5F5F5',
  },
  instructions: {
    textAlign: 'center',
    color: '#A0A0A0',
  },
});

module.exports = MainScreen;

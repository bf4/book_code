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
  ToolbarAndroid,
  AppRegistry,
  Navigator,
  StyleSheet,
  Component,
} from 'react-native';

import MainScreen from './screens/MainScreen';

class Notes extends Component {

  constructor(props) {
    super(props)
    this.menuActions = [
      { title: 'New', show: 'ifRoom' }
    ]
  }

  render() {
    return (
      <Navigator
          initialRoute={{name: 'Notes', index: 0}}
          renderScene={(route, navigator) =>
            <View style={{flex:1}}>
              <ToolbarAndroid
                title="Notes"
                actions={this.menuActions}
                style={styles.toolbar}
                />
              <MainScreen />
            </View>
        }
      />
    );
  }
};

var styles = StyleSheet.create({
  toolbar: {
    backgroundColor: '#DDDDDD',
    height: 56,
  },
});

AppRegistry.registerComponent('Notes', () => Notes);

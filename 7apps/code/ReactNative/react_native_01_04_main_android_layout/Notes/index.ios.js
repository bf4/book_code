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
  Text,
  AppRegistry,
  Navigator,
  StyleSheet,
  TouchableOpacity,
  Component,
} from 'react-native';

import MainScreen from './screens/MainScreen';

class Notes extends Component {

  constructor(props) {
    super(props)
    this.navigationBarRouteMapper = {
      LeftButton: function(route, navigator, index, navState) {
        return null;
      },
      Title: function(route, navigator, index, navState) {
        return(
          <Text style={styles.navBarTitle}>
            Notes
          </Text>
        );
      },
      RightButton: function(route, navigator, index, navState) {
        return(
          <TouchableOpacity>
            <Text style={styles.navButtonText}>
              New
            </Text>
          </TouchableOpacity>
        );
      },
    }
  }

  render() {
    return (
      <Navigator
          initialRoute={{name: 'Notes', index: 0}}
          renderScene={(route, navigator) => <MainScreen /> }
          navigationBar={
            <Navigator.NavigationBar
              style={styles.navBar}
              routeMapper={this.navigationBarRouteMapper}
            />
          }
        />
    );
  }

};

var styles = StyleSheet.create({
  navBar: {
    backgroundColor: '#F5F5F5',
    alignItems: 'center',
  },
  navButtonText: {
    paddingTop: 14,
    paddingRight: 8,
    color: '#005DB3',
  },
  navBarTitle: {
    fontSize: 18,
    fontWeight: '500',
    marginTop: 10,
  },
});

AppRegistry.registerComponent('Notes', () => Notes);

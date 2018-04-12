/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
import React, {
  Text,
  AppRegistry,
  Navigator,
  StyleSheet,
  TouchableOpacity,
  View,
  Component,
} from 'react-native';

import MainScreen from './screens/MainScreen';
import NewNote    from './screens/NewNote';

var navButtonFactory = function(config) {
  return (
    <TouchableOpacity
      onPress={() => config.actionFunction()}>
      <Text style={config.styleArray}>
        {config.title}
      </Text>
    </TouchableOpacity>
  );
};

class Notes extends Component {

  constructor(props) {
    super(props)
    this.mainRoute = {name: 'Notes'};
    this.newNoteRoute = {name: 'New Note'};
  }

  initialRoute() {
    return this.mainRoute;
  }

  render() {
    var navigationBarRouteMapper = {
      indexPage: this,
      LeftButton: function(route, navigator, index, navState) {
        return this.indexPage.leftButtonForRoute(route, navigator);
      },
      Title: function(route, navigator, index, navState) {
        return(
          <Text style={styles.navBarTitle}>
            {route.name}
          </Text>
        );
      },
      RightButton: function(route, navigator, index, navState) {
        return this.indexPage.rightButtonForRoute(route, navigator);
      },
    };

    return (
      <Navigator
          initialRoute={this.initialRoute()}
          renderScene={(route, navigator) => (
            <View style={styles.screen}>
              {this.screenForRouteNavigator(route, navigator)}
            </View>
          )}
          navigationBar={
            <Navigator.NavigationBar
              style={styles.navBar}
              routeMapper={navigationBarRouteMapper}
            />
          }
        />
    );
  }

  screenForRouteNavigator(route, navigator) {
    switch(route.name) {
      case this.mainRoute.name: return (
        <MainScreen style={styles.screen} />
      );
      case this.newNoteRoute.name: return (
        <NewNote style={styles.screen} />
      );
    }
  }

  leftButtonForRoute(route, navigator) {
    var action = null;
    var title = null;
    switch(route.name) {
      case this.mainRoute.name: return null;
      case this.newNoteRoute.name:
        action = () => navigator.pop();
        title = 'Cancel';
        break;
    }
    return navButtonFactory({
      title: title,
      actionFunction: action,
      styleArray: [styles.navButtonText, styles.navButtonLeft]
    });
  }

  rightButtonForRoute(route, navigator) {
    var action = null;
    var title = null;
    switch(route.name) {
      case this.mainRoute.name:
        action = () => navigator.push(this.newNoteRoute);
        title = 'New';
        break;
      case this.newNoteRoute.name:
        action = () => {return null};
        title = 'Save';
        break;
    }
    return navButtonFactory({
      title: title,
      actionFunction: action,
      styleArray: [styles.navButtonText, styles.navButtonRight]
    });
  }

};

var styles = StyleSheet.create({
  navBar: {
    backgroundColor: '#F5F5F5',
  },
  navButtonText: {
    paddingTop: 14,
    color: '#005DB3',
  },
  navButtonRight: {
    paddingRight: 8,
  },
  navButtonLeft: {
    paddingLeft: 8,
  },
  navBarTitle: {
    fontSize: 18,
    fontWeight: '500',
    marginTop: 10,
  },
  screen: {
    flex:1,
    paddingTop: 64,
  }
});

AppRegistry.registerComponent('Notes', () => Notes);

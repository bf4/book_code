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
  TouchableOpacity,
  View,
  Component,
} from 'react-native';

import EventEmitter   from 'EventEmitter';
import MainScreen     from './screens/MainScreen';
import NewNote        from './screens/NewNote';
import NotesDataModel from './data/NotesDataModel';
import styles         from './styles';
import routes         from './routes';

var navButtonFactory = function(config) {
  return (
    <TouchableOpacity
      onPress={() => config.actionFunction()}>
      <Text style={config.styleArray}>
        {config.title}
      </Text>
    </TouchableOpacity>
  );
}

class Notes extends Component {

  constructor(props) {
    super(props)

    this.currentNavigator = null;
    this.noteDataModel = new NotesDataModel();
    this.saveEventEmitter = new EventEmitter();
  }

  savePressed() {
    this.saveEventEmitter.emit('shouldSaveNewNote',
                               {model:this.noteDataModel});
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
          initialRoute={routes.initialRoute()}
          renderScene={(route, navigator) => (
            <View style={styles.iosContainer}>
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
      case routes.mainRoute.name: return (<MainScreen />);
      case routes.newNoteRoute.name: return (
        <NewNote
          saveEventEmitter={this.saveEventEmitter}
          noteDataModel={this.noteDataModel} />
      );
    }
  }

  leftButtonForRoute(route, navigator) {
    var action = null;
    var title = null;
    switch(route.name) {
      case routes.mainRoute.name: return null;
      case routes.newNoteRoute.name:
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
      case routes.mainRoute.name:
        action = () => navigator.push(routes.newNoteRoute);
        title = 'New';
        break;
      case routes.newNoteRoute.name:
        action = () => {
          this.savePressed();
          navigator.pop();
        }
        title = 'Save';
        break;
    }
    return navButtonFactory({
      title: title,
      actionFunction: action,
      styleArray: [styles.navButtonText, styles.navButtonRight]
    });
  }

}

AppRegistry.registerComponent('Notes', () => Notes);

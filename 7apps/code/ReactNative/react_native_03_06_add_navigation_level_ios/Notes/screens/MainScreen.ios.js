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
  TabBarIOS,
  Text,
  Component,
} from 'react-native';

import NoteList from './NoteList';
import styles   from '../styles';

class MainScreen extends Component {

  constructor(props) {
    super(props)
    this.state = {
      selectedTab: 'listTab',
    };
  }

  screenForTab() {
    switch(this.state.selectedTab) {
      case 'listTab':
      return(
        <NoteList noteDataModel={this.props.noteDataModel} />
      );
      break;
      case 'mapTab':
      return(
        <Text>Map Tab</Text>
      );
      break;
    }
  }

  render() {
    var mainScreen = this;
    return (
      <TabBarIOS
        barTintColor="#F5F5F5">
        <TabBarIOS.Item
          title="List"
          selected={this.state.selectedTab === 'listTab'}
          onPress={() => {
            this.setState({
              selectedTab: 'listTab',
            });
          }}>
          {this.screenForTab()}
        </TabBarIOS.Item>
        <TabBarIOS.Item
          title="Map"
          selected={this.state.selectedTab === 'mapTab'}
          onPress={() => {
            this.setState({
              selectedTab: 'mapTab',
            });
          }}>
          {this.screenForTab()}
        </TabBarIOS.Item>
      </TabBarIOS>
    );
  }

}

module.exports = MainScreen;

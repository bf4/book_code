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
  Text,
  ListView,
  Component,
  TouchableOpacity,
  ViewPagerAndroid,
} from 'react-native';

import NoteList from './NoteList';
import styles   from '../styles';

class TabButton extends Component {

  constructor(props) {
    super(props)
    this.titleClicked = this.titleClicked.bind(this);
    this.selectedView = this.selectedView.bind(this);
  }

  render() {
    return (
      <View style={styles.androidTabButton}>
        <TouchableOpacity
          onPress={() => this.titleClicked() }>
          <Text style={styles.androidTabButtonTitle}>
            {this.props.title}
          </Text>
        </TouchableOpacity>
        {this.selectedView()}
      </View>
    );
  }

  titleClicked() {
    if (this.props.onClick) {
      this.props.onClick(this.props.position);
    }
  }

  selectedView() {
    if (this.props.selected()) {
      return (
        <View style={styles.androidTabButtonSelected} />
      );
    } else {
      return null;
    }
  }

}

class MainScreen extends Component {

  constructor(props) {
    super(props)
    var model = this.props.noteDataModel;
    this.state = {
      selectedTab: 0,
      dataSource: model.newDataSourceFromRows(),
    };
    this.updateDataSource = this.updateDataSource.bind(this);
    this.onPageSelected = this.onPageSelected.bind(this);
    this.tabButtonClicked = this.tabButtonClicked.bind(this);
  }

  componentDidMount() {
    var model = this.props.noteDataModel;
    model.addListener('noteRowsUpdated', this.updateDataSource);
    model.fetchAllNotes();
  }

  componentWillUnmount() {
    var model = this.props.noteDataModel;
    model.removeAllListeners('noteRowsUpdated');
  }

  onPageSelected(event) {
    this.setState({selectedTab: event.nativeEvent.position});
  }

  tabButtonClicked(position) {
    this.refs.viewPager.setPage(position);
    this.setState({selectedTab: position});
  }

  updateDataSource() {
    var model = this.props.noteDataModel;
    this.setState({
      dataSource: model.newDataSourceFromRows(),
    });
  }

  render() {
    var mainScreen = this;
    return (
      <View style={{flex:1}}>
        {}
        <View style={{flexDirection:'row'}}>
          <TabButton
            title="List"
            position={0}
            selected={() => mainScreen.state.selectedTab === 0}
            onClick={this.tabButtonClicked}
          />
          <TabButton
            title="Map"
            position={1}
            selected={() => mainScreen.state.selectedTab === 1}
            onClick={this.tabButtonClicked}
          />
        </View>
        {}
        {}
        <ViewPagerAndroid
          ref="viewPager"
          style={styles.viewPager}
          initialPage={0}
          onPageSelected={this.onPageSelected} >
          <View style={styles.pageStyle}>
            <NoteList
              noteDataModel={this.props.noteDataModel} />
          </View>
          <View style={styles.pageStyle}>
            <Text>Second page</Text>
          </View>
        </ViewPagerAndroid>
        {}
      </View>
    );
  }
}

module.exports = MainScreen;

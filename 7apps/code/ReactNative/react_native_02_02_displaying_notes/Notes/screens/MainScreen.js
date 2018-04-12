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
} from 'react-native';

import styles from '../styles';

class MainScreen extends Component {

  constructor(props) {
    super(props)
    var model = this.props.noteDataModel;
    this.state = {
      dataSource: model.newDataSourceFromRows(),
    };
    this.updateDataSource = this.updateDataSource.bind(this);
    this.listView = this.listView.bind(this);
  }

  componentDidMount() {
    var model = this.props.noteDataModel;
    model.addListener('noteRowsUpdated', this.updateDataSource);
  }

  componentWillUnmount() {
    var model = this.props.noteDataModel;
    model.removeAllListeners('noteRowsUpdated');
  }

  updateDataSource() {
    var model = this.props.noteDataModel;
    this.setState({
      dataSource: model.newDataSourceFromRows(),
    });
  }

  render() {
    var rowCount = this.state.dataSource.getRowCount();
    var content = rowCount === 0 ? this.noDataScreen() : this.listView();
    return content;
  }

  listView() {
    var model = this.props.noteDataModel;
    return (
      <ListView
        dataSource={this.state.dataSource}
        renderRow={this.renderRow}
        />
    );
  }

  renderRow(note) {
    return(<Text>{note.title}</Text>);
  }

  noDataScreen() {
    return (
      <View style={styles.noDataScreen}>
        <Text style={styles.noDataMessage}>
          Create a note.
        </Text>
      </View>
    );
  }
}

module.exports = MainScreen;

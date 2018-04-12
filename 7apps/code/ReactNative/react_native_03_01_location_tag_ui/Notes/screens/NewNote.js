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
  Text,
  TouchableOpacity,
  Component,
} from 'react-native';

import styles from '../styles';

class NewNote extends Component {
  componentDidMount() {
    this.props.saveEventEmitter.addListener('shouldSaveNewNote',
                                         this.saveNote, this);
  }

  componentWillUnmount() {
    this.props.saveEventEmitter.removeAllListeners('shouldSaveNewNote');
  }

  saveNote({model:model}) {
    model.createNewNote(
      this.state.noteTitle,
      this.state.noteBody
    );
  }

  addLocationPressed() {

  }

  render() {
    return (
      <View style={styles.container}>
        <TextInput
          ref='titleText'
          placeholder="Note Title"
          onChangeText={(text) =>
            this.setState({noteTitle:text})}
          style={[styles.noteTextInput, styles.titleTextInput]} />
        <View style={styles.divider} />
        <View style={styles.locationButtonContainer}>
          <TouchableOpacity
            onPress={this.addLocationPressed}>
            <Text style={styles.locationPreferenceLabel}>
              Add current location
            </Text>
          </TouchableOpacity>
        </View>
        <View style={styles.divider} />
        <TextInput
          ref='bodyText'
          placeholder="Enter a note..."
          multiline={true}
          textAlignVertical='top'
          onChangeText={(text) =>
            this.setState({noteBody:text})}
          style={[styles.noteTextInput, styles.noteBodyTextInput]} />
      </View>
    );
  }
}

module.exports = NewNote;

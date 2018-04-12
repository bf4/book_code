/***
 * Excerpted from "Craft GraphQL APIs in Elixir with Absinthe",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/wwgraphql for more book information.
***/
import React, { Component } from 'react';

class App extends Component {

  // Retrieves current data for menu items
  get menuItems() {
    // TODO: Replace with real data!
    return [
      {id: "stub-1", name: "Stub Menu Item 1"},
      {id: "stub-2", name: "Stub Menu Item 2"},
      {id: "stub-3", name: "Stub Menu Item 3"},
    ];
  }

  renderMenuItem(menuItem) {
    return (
      <li key={menuItem.id}>{menuItem.name}</li> 
    );
  }

  // Build the DOM
  render() {
    return (
      <ul>
        {this.menuItems.map(menuItem => this.renderMenuItem(menuItem))}
      </ul>
    );
  }

}

export default App;

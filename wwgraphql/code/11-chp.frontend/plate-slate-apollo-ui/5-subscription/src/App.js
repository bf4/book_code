/***
 * Excerpted from "Craft GraphQL APIs in Elixir with Absinthe",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/wwgraphql for more book information.
***/
import React, { Component } from 'react';

// GraphQL
import { graphql } from 'react-apollo';
import gql from 'graphql-tag';

class App extends Component {

  componentWillMount() {
    this.props.subscribeToNewMenuItems();
  }

  // Retrieves current data for menu items
  get menuItems() {
    const { data } = this.props;
    if (data && data.menuItems) {
      return data.menuItems;
    } else {
      return [];
    }
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

const query = gql`
  { menuItems { id name } }
`;

const subscription = gql`
  subscription {
    newMenuItem { id name }
  }
`;

export default graphql(query, {
  props: props => {
    return Object.assign(props, {
      subscribeToNewMenuItems: params => { 
        return props.data.subscribeToMore({
          document: subscription,
          updateQuery: (prev, { subscriptionData }) => {
            if (!subscriptionData.data) {
              return prev;
            }
            const newMenuItem = subscriptionData.data.newMenuItem;
            return Object.assign({}, prev, { 
              menuItems: [newMenuItem, ...prev.menuItems]
            });
          }
        })
      }
    });
  }
})(App);

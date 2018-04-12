/***
 * Excerpted from "Craft GraphQL APIs in Elixir with Absinthe",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/wwgraphql for more book information.
***/
import React, { Component } from 'react';

import { QueryRenderer, graphql } from 'react-relay';

import environment from './relay-environment';

const query = graphql`
  query AppQuery { menuItems { id name } }
`;

class App extends Component {

  renderMenuItem(menuItem) {
    return (
      <li key={menuItem.id}>{menuItem.name}</li>
    );
  }

  render() {
    return (
      <QueryRenderer
        environment={environment}
        query={query}
        render={({ error, props }) => {
          if (error) {
            return (
              <div>{error.message}</div>
            );
          } else if (props) {
            return (
              <ul>
                {props.menuItems.map(this.renderMenuItem)}
              </ul>
            );
          } else {
            return (
              <div>Loading...</div>
            )
          }
        }}
        />
    );
  }
}

export default App;

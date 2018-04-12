/***
 * Excerpted from "Craft GraphQL APIs in Elixir with Absinthe",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/wwgraphql for more book information.
***/
import { graphql, requestSubscription } from 'react-relay';

import environment from '../relay-environment';

const newMenuItemSubscription = graphql`
  subscription NewMenuItemSubscription {
    newMenuItem { id name }
  }
`

export default () => {

  const subscriptionConfig = {
    subscription: newMenuItemSubscription,
    variables: {},
    updater: proxyStore => {
      // Get the new menu item
      const newMenuItem = proxyStore.getRootField('newMenuItem');
      // Get existing menu items
      const root = proxyStore.getRoot();
      const menuItems = root.getLinkedRecords('menuItems');
      // Prepend the new menu item
      root.setLinkedRecords([newMenuItem, ...menuItems], 'menuItems');
    },
    onError: error => console.log(`An error occured:`, error)
  }

  requestSubscription(
    environment,
    subscriptionConfig
  )

}

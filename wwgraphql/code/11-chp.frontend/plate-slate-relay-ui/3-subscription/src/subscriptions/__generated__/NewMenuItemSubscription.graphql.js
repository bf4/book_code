/***
 * Excerpted from "Craft GraphQL APIs in Elixir with Absinthe",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/wwgraphql for more book information.
***/
/**
 * @flow
 * @relayHash ba237a5366e8608bfbb6837f42273b04
 */

/* eslint-disable */

'use strict';

/*::
import type {ConcreteBatch} from 'relay-runtime';
export type NewMenuItemSubscriptionVariables = {| |};
export type NewMenuItemSubscriptionResponse = {|
  +newMenuItem: ?{|
    +id: ?string;
    +name: ?string;
  |};
|};
*/


/*
subscription NewMenuItemSubscription {
  newMenuItem {
    id
    name
  }
}
*/

const batch /*: ConcreteBatch*/ = {
  "fragment": {
    "argumentDefinitions": [],
    "kind": "Fragment",
    "metadata": null,
    "name": "NewMenuItemSubscription",
    "selections": [
      {
        "kind": "LinkedField",
        "alias": null,
        "args": null,
        "concreteType": "MenuItem",
        "name": "newMenuItem",
        "plural": false,
        "selections": [
          {
            "kind": "ScalarField",
            "alias": null,
            "args": null,
            "name": "id",
            "storageKey": null
          },
          {
            "kind": "ScalarField",
            "alias": null,
            "args": null,
            "name": "name",
            "storageKey": null
          }
        ],
        "storageKey": null
      }
    ],
    "type": "RootSubscriptionType"
  },
  "id": null,
  "kind": "Batch",
  "metadata": {},
  "name": "NewMenuItemSubscription",
  "query": {
    "argumentDefinitions": [],
    "kind": "Root",
    "name": "NewMenuItemSubscription",
    "operation": "subscription",
    "selections": [
      {
        "kind": "LinkedField",
        "alias": null,
        "args": null,
        "concreteType": "MenuItem",
        "name": "newMenuItem",
        "plural": false,
        "selections": [
          {
            "kind": "ScalarField",
            "alias": null,
            "args": null,
            "name": "id",
            "storageKey": null
          },
          {
            "kind": "ScalarField",
            "alias": null,
            "args": null,
            "name": "name",
            "storageKey": null
          }
        ],
        "storageKey": null
      }
    ]
  },
  "text": "subscription NewMenuItemSubscription {\n  newMenuItem {\n    id\n    name\n  }\n}\n"
};

module.exports = batch;

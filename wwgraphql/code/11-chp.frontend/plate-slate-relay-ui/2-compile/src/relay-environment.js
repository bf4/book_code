/***
 * Excerpted from "Craft GraphQL APIs in Elixir with Absinthe",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/wwgraphql for more book information.
***/
import { createFetcher, createSubscriber } from "@absinthe/socket-relay";
import {
  Environment,
  Network,
  RecordSource,
  Store
} from "relay-runtime";

import absintheSocket from "./absinthe-socket";

export default new Environment({
  network: Network.create(
    createFetcher(absintheSocket),
    createSubscriber(absintheSocket)
  ),
  store: new Store(new RecordSource())
});

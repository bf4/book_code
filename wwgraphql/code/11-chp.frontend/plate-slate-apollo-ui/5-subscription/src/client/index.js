/***
 * Excerpted from "Craft GraphQL APIs in Elixir with Absinthe",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/wwgraphql for more book information.
***/
import ApolloClient from "apollo-client";
import { InMemoryCache } from "apollo-cache-inmemory";
import { ApolloLink } from "apollo-link";
import { createHttpLink } from "apollo-link-http";
import { hasSubscription } from "@jumpn/utils-graphql";

import absintheSocketLink from "./absinthe-socket-link";

const link = new ApolloLink.split(
  operation => hasSubscription(operation.query),
  absintheSocketLink,
  createHttpLink({uri: "http://localhost:4000/api/graphql"})
);

export default new ApolloClient({
  link,
  cache: new InMemoryCache()
});

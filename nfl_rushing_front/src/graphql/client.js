import { ApolloClient } from 'apollo-client'
import { createHttpLink } from 'apollo-link-http'
import { InMemoryCache } from 'apollo-cache-inmemory'

// Here we define the ling to our GraphQL endpoint
const httpLink = createHttpLink({
  uri: 'http://localhost:3000/graphql'
})

// Even though we're not going to use Apollo cache at all, we still need to provide it when creating Apollo Client instance
const cache = new InMemoryCache()
const AUTH_TOKEN = 'apollo-token'
export const apolloClient = new ApolloClient({
  link: httpLink,
  cache,
  // We disable the Apollo cache here because we use Vuex as a single source of truth
  defaultOptions: {
    query: {
      fetchPolicy: 'network-only',
      tokenName: AUTH_TOKEN
    }
  }
})

import Vue from 'vue'
import Vuex from 'vuex'
import { apolloClient } from '../graphql/client'
import rushingsData from '@/graphql/RushingsConnection.gql'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    rushings: [],
    connectionInfo: []
  },
  mutations: {
    setRushingsStats (state, rushings) {
      state.rushings = rushings
    },
    setMoreRushingsStats (state, moreRushings) {
      state.rushings.edges.push(moreRushings.edges)
      state.rushings.pageInfo.endCursor = moreRushings.pageInfo.endCursor
    }
  },
  actions: {
    async fetchRushingsStats (context, options) {
      console.log(options)
      await apolloClient.query({
        query: rushingsData,
        variables: {
          sortBy: options.sortBy,
          sortDesc: options.sortDesc,
          nameFilter: options.filter,
          first: options.first,
          last: options.last,
          after: options.endCursor,
          before: options.startCursor
        }
      }).then((res) => context.commit('setRushingsStats', res.data.rushings))
    }
  }
})

export default store

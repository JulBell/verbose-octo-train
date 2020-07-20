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
    }
  },
  actions: {
    async fetchRushingsStats (context, options) {
      await apolloClient.query({
        query: rushingsData,
        variables: {
          sortBy: options.sortBy,
          sortDesc: options.sortDesc,
          nameFilter: options.filter,
          first: null
        }
      }).then((res) => context.commit('setRushingsStats', res.data.rushings))
    }
  }
})

export default store

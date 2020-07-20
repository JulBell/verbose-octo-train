import Vue from 'vue'
import Vuex from 'vuex'
import { apolloClient } from '../graphql/client'
import rushingsData from '@/graphql/RushingsConnection.gql'

Vue.use(Vuex)

const store = new Vuex.Store({
  // apollo: {
  //   rushings: {
  //     query: users
  //   }
  // },
  state: {
    rushings: []
  },
  mutations: {
    setRushingsStats (state, rushings) {
      state.rushings = rushings.nodes
    }
  },
  actions: {
    async fetchRushingsStats (context) {
      console.log('dispatch')
      await apolloClient.query({
        query: rushingsData,
        variables: {
        }
      }).then((res) => context.commit('setRushingsStats', res.data.rushings))
    }
  }
})

export default store

// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import { createProvider } from './vue-apollo'
import store from './store/store'

import '@/assets/scss/app.scss'
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  store: store,
  router,
  components: { App },
  apolloProvider: createProvider(),
  template: '<App/>'
})

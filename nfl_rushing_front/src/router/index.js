import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/* eslint-disable */
const routerOptions = {
        mode: 'history',
        routes: [{
            path: '/:guid?',
            name: 'RushingList',
            component: () =>
                import ( /* webpackChunkName: "r.rushingList" */ '@/pages/RushingList'),
            props: true
        }]
    }
    // eslint-enable

    export default new Router(routerOptions)
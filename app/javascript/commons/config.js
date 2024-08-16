import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import VueAxios from 'vue-axios'
import VueRouter from 'vue-router'
import dayjs from 'dayjs'

import App from '@/commons/App'
import VueCanCanCan from '@/commons/plugins/can'
import { setCSRFToken } from '@/commons/interceptors/csrf'
import { loadJWT } from '@/commons/interceptors/jwt'

Vue.prototype.$env = process.env.NODE_ENV
Vue.prototype.$dayjs = dayjs
Vue.prototype.$gon = gon

Vue.config.productionTip = false

Vue.use(VueRouter)
Vue.use(Vuex)
Vue.use(VueAxios, axios)
Vue.use(VueCanCanCan, gon.abilities)

// Interctepors
setCSRFToken()
loadJWT()

function initVueConfig(routes, baseStore, components, directives, plugins) {
  const store = new Vuex.Store(baseStore)
  const router = new VueRouter({ routes })

  // TODO: Перекинуть в функцию
  router.beforeEach((to, from, next) => {
    document.title = to.meta.title || "Заголовок по умолчанию"
    next()
  })

  components?.forEach((component) => {
    Vue.component(component.name, component.component)
  })

  directives?.forEach((directive) => {
    Vue.directive(directive.name, directive.component)
  })

  plugins?.forEach((plugin) => {
    Vue.use(plugin.name, plugin.component)
  })

  return new Vue({
    store,
    router,
    render: (h) => h(App)
  })
}

export { initVueConfig }
import Vue from 'vue'
import App from '@/main/App'
import { routes } from '@/main/routes/index'
import { baseStore } from '@/main/store/index.js'
import VueRouter from 'vue-router'
import Vuex from 'vuex'
import { setCSRFToken } from '@/commons/interceptors/csrf'

Vue.use(VueRouter)
Vue.use(Vuex)

const router = new VueRouter({ routes })
const store = new Vuex.Store(baseStore)

/**
 * Load JWT from Local Storage on Refresh.
*/
let localAuthToken = localStorage.auth_token;
let cookieExists = localAuthToken !== "undefined" && localAuthToken !== null;
if (cookieExists) {
  const auth_token = localStorage.getItem("auth_token");
  const authTokenExists = auth_token !== "undefined" && auth_token !== null;
  if (authTokenExists) {
    store.dispatch("session/loginUserWithToken", { auth_token });
  }
}

setCSRFToken()

const app = new Vue({
  el: "#main-app",
  router,
  store,
  render: (h) => h(App)
})

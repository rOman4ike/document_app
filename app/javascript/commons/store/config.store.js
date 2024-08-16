import Vue from "vue"

export const configStore = {
  state: {
    authenticityToken: '',
    user: {},
  },
  mutations: {
    SET_AUTHENTICITY_TOKEN(state) {
      const token = document.querySelector("meta[name='csrf-token']").getAttribute('content')
      Vue.set(state, 'authenticityToken', token)
    },
    SET_USER(state, user) {
      Vue.set(state, 'user', user)
    },
  }
}
import Vue from "vue"
import axios from "axios"

export const userStore = {
  state: {
    user: {}
  },
  mutations: {
    SET_USER_PROPERTY(state, { key, value }) {
      Vue.set(state.user, key, value)
    },
    SET_USER(state, user) {
      Vue.set(state, 'user', user)
    },
  },
  actions: {
    createUser({ commit }, params) {
      return new Promise((resolve) => {
        return axios.post('api/v1/users', params)
          .then(response => {
            if (response.status == 200) {
              commit('SET_USER', response.data.user)
              resolve(resolve)
            }
          })
      })
    },
  }
}
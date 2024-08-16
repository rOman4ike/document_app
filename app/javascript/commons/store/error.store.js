import Vue from "vue"

export const errorStore = {
  state: {
    errors: {},
  },
  mutations: {
    SET_ERRORS(state, errors) {
      Vue.set(state, 'errors', errors)
    },
  }
}
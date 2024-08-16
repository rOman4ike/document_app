import Vue from "vue"
import axios from 'axios'

const INITIAL_INITIAL_ORDER = {
  number: ''
}

export const initialOrderStore = {
  state: {
    initialOrder: {
      number: ''
    },
  },
  mutations: {
    SET_INITIAL_ORDER_PROPERTY(state, { key, value }) {
      Vue.set(state.initialOrder, key, value)
    },
    SET_INITIAL_ORDER(state, initialOrder) {
      Vue.set(state, 'initialOrder', initialOrder)
    },
    SET_INITIAL_INITIAL_ORDER(state) {
      Vue.set(state, 'initialOrder', INITIAL_INITIAL_ORDER)
    }
  },
  getters: {
    getInitialOrderInitialDate(state) {
      return Vue.prototype
        .$dayjs(state.initialOrder.initial_date)
        .format('DD.MM.YYYY')
    }
  }
}
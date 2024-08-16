import Vue from "vue"
import axios from 'axios'

const INITIAL_CHANGE_ORDER = {
  number: ''
}

export const changeOrderStore = {
  state: {
    changeOrder: {
      number: ''
    },
    changeOrders: [],
  },
  mutations: {
    SET_CHANGE_ORDER_PROPERTY(state, { key, value }) {
      Vue.set(state.changeOrder, key, value)
    },
    SET_CHANGE_ORDER(state, changeOrder) {
      Vue.set(state, 'changeOrder', changeOrder)
    },
    SET_CHANGE_ORDERS(state, changeOrders) {
      Vue.set(state, 'changeOrders', changeOrders)
    },
    SET_INITIAL_CHANGE_ORDER(state) {
      Vue.set(state, 'changeOrder', INITIAL_CHANGE_ORDER)
    }
  },
  actions: {
    deleteChangeOrder({ commit }, changeOrderId) {
      return new Promise((resolve, reject) => {
        axios.delete(`api/v1/change_orders/${changeOrderId}`).then(response => {
          if (response.status == 200) {
            resolve(response)
          }
        })
      })
    }
  },
  getters: {
    getChangeOrderChangeDate(state) {
      return Vue.prototype
        .$dayjs(state.changeOrder.change_date)
        .format('DD.MM.YYYY')
    },
    getChangeOrderDeletedAt: (state) => (index) => {
      return Vue.prototype
        .$dayjs(state.changeOrders[index].deleted_at)
        .format('DD.MM.YYYY H:mm')
    }
  }
}
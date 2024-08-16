import Vue from "vue"
import axios from 'axios'

export const activityAreaStore = {
  state: {
    activityArea: {},
    activityAreas: [],
    activityAreaPagination: {}
  },
  mutations: {
    SET_ACTIVITY_AREA_PROPERTY(state, { key, value }) {
      Vue.set(state.activityArea, key, value)
    },
    SET_ACTIVITY_AREA(state, activityArea) {
      Vue.set(state, 'activityArea', activityArea)
    },
    SET_ACTIVITY_AREAS(state, activityAreas) {
      Vue.set(state, 'activityAreas', activityAreas)
    },
    SET_ACTIVITY_AREA_PAGINATION(state, activityAreaPagination) {
      Vue.set(state, 'activityAreaPagination', activityAreaPagination)
    }
  },
  actions: {
    getActivityAreas({ commit }, params) {
      return new Promise((resolve, reject) => {
        axios.get('api/v1/activity_areas', { params: params }).then(response => {
          if (response.status == 200) {
            commit('SET_ACTIVITY_AREAS', response.data.activity_areas)
            commit('SET_ACTIVITY_AREA_PAGINATION', response.data.pagination)
            resolve(response)
          }
        })
      })
    },
    createActivityArea({ commit }, params) {
      return new Promise((resolve, reject) => {
        axios.post(`api/v1/activity_areas`, params)
          .then(response => {
            if (response.status == 200) {
              commit('SET_ACTIVITY_AREA', {})
              resolve(response)
            }
          })
          .catch(error => {
            if (error.response.data?.errors) {
              commit('error/SET_ERRORS', error.response.data.errors, { root: true })
              reject(error)
            }
          })
      })
    },
    updateActivityArea({ commit }, { params, activityAreaId }) {
      return new Promise((resolve, reject) => {
        axios.patch(`api/v1/activity_areas/${activityAreaId}`, params)
          .then(response => {
            if (response.status == 200) {
              commit('SET_ACTIVITY_AREA', {})
              resolve(response)
            }
          })
          .catch(error => {
            if (error.response.data?.errors) {
              commit('error/SET_ERRORS', error.response.data.errors, { root: true })
              reject(error)
            }
          })
      })
    },
    deleteActivityArea({ commit }, activityAreaId) {
      return new Promise((resolve, reject) => {
        axios.delete(`api/v1/activity_areas/${activityAreaId}`)
          .then(response => {
            if (response.status == 200) {
              resolve(response)
            }
          })
          .catch(error => {
            if (error.response.data?.errors) {
              commit('error/SET_ERRORS', error.response.data.errors, { root: true })
              reject(error)
            }
          })
      })
    }
  }
}
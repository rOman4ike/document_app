import Vue from "vue"
import axios from 'axios'

export const docTagStore = {
  state: {
    docTag: {},
    docTags: [],
    docTagPagination: {}
  },
  mutations: {
    SET_DOC_TAG_PROPERTY(state, { key, value }) {
      Vue.set(state.docTag, key, value)
    },
    SET_DOC_TAG(state, docTag) {
      Vue.set(state, 'docTag', docTag)
    },
    SET_DOC_TAGS(state, docTags) {
      Vue.set(state, 'docTags', docTags)
    },
    SET_DOC_TAG_PAGINATION(state, docTagPagination) {
      Vue.set(state, 'docTagPagination', docTagPagination)
    }
  },
  actions: {
    getDocTags({ commit }, params) {
      return new Promise((resolve, reject) => {
        axios.get('api/v1/doc_tags', { params: params }).then(response => {
          if (response.status == 200) {
            commit('SET_DOC_TAGS', response.data.doc_tags)
            commit('SET_DOC_TAG_PAGINATION', response.data.pagination)
            resolve(response)
          }
        })
      })
    },
    createDocTag({ commit }, params) {
      return new Promise((resolve, reject) => {
        axios.post(`api/v1/doc_tags`, params)
          .then(response => {
            if (response.status == 200) {
              commit('SET_DOC_TAG', {})
              resolve(response)
            }
          })
          .catch(error => {
            console.log(error.response.data);
            if (error.response.data?.errors) {
              commit('error/SET_ERRORS', error.response.data.errors, { root: true })
              reject(error)
            }
          })
      })
    },
    updateDocTag({ commit }, { params, docTagId }) {
      return new Promise((resolve, reject) => {
        axios.patch(`api/v1/doc_tags/${docTagId}`, params)
          .then(response => {
            if (response.status == 200) {
              commit('SET_DOC_TAG', {})
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
    deleteDocTag({ commit }, docTagId) {
      return new Promise((resolve, reject) => {
        axios.delete(`api/v1/doc_tags/${docTagId}`)
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
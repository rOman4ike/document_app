import Vue from "vue"
import axios from 'axios'

export const documentStore = {
  state: {
    document: {
      document_activity_areas: [],
      document_doc_tags: []
    },
    documents: [],
    availableDocumentStateValues: [],
    availableDocumentKindValues: [],
    documentVersions: [],
    documentPagination: {}
  },
  mutations: {
    SET_DOCUMENT_PROPERTY(state, { key, value }) {
      Vue.set(state.document, key, value)
    },
    SET_DOCUMENTS(state, documents) {
      Vue.set(state, 'documents', documents)
    },
    SET_DOCUMENT(state, document) {
      Vue.set(state, 'document', document)
    },
    SET_DOCUMENT_VERSIONS(state, documentVersions) {
      Vue.set(state, 'documentVersions', documentVersions)
    },
    SET_AVAILABLE_DOCUMENT_STATE_VALUES(state, availableDocumentStateValues) {
      Vue.set(state, 'availableDocumentStateValues', availableDocumentStateValues)
    },
    SET_AVAILABLE_DOCUMENT_KIND_VALUES(state, availableDocumentKindValues) {
      Vue.set(state, 'availableDocumentKindValues', availableDocumentKindValues)
    },
    SET_DOCUMENT_PAGINATION(state, documentPagination) {
      Vue.set(state, 'documentPagination', documentPagination)
    }
  },
  actions: {
    getDocuments({ commit }, params) {
      return new Promise((resolve, reject) => {
        axios.get('api/v1/documents', { params: params }).then(response => {
          if (response.status == 200) {
            commit('SET_DOCUMENTS', response.data.documents)
            commit('SET_DOCUMENT_PAGINATION', response.data.pagination)
            commit('SET_AVAILABLE_DOCUMENT_STATE_VALUES', response.data.available_document_state_values)
            commit('SET_AVAILABLE_DOCUMENT_KIND_VALUES', response.data.available_document_kind_values)
            commit('activityArea/SET_ACTIVITY_AREAS', response.data.activity_areas, { root: true })
            commit('docTag/SET_DOC_TAGS', response.data.doc_tags, { root: true })
            resolve(response)
          }
        })
      })
    },
    getDocument({ commit }, documentId) {
      return new Promise((resolve, reject) => {
        axios.get(`api/v1/documents/${documentId}`).then(response => {
          if (response.status == 200) {
            commit('SET_DOCUMENT', response.data.document)
            commit('SET_DOCUMENT_VERSIONS', response.data.versions || [])
            commit('documentFile/SET_DOCUMENT_FILE', response.data.document_file, { root: true })
            commit('documentFile/SET_DOCUMENT_FILES', response.data.document_files || [], { root: true })
            commit('initialOrder/SET_INITIAL_ORDER', response.data.initial_order || {}, { root: true })
            commit('changeOrder/SET_CHANGE_ORDER', response.data.change_order || {}, { root: true })
            commit('changeOrder/SET_CHANGE_ORDERS', response.data.change_orders || [], { root: true })
            resolve(response)
          }
        })
      })
    },
    getDocumentForCreate({ commit }) {
      return new Promise((resolve, reject) => {
        axios.get(`api/v1/documents/new`).then(response => {
          if (response.status == 200) {
            commit('SET_AVAILABLE_DOCUMENT_STATE_VALUES', response.data.available_document_state_values)
            commit('SET_AVAILABLE_DOCUMENT_KIND_VALUES', response.data.available_document_kind_values)
            commit('activityArea/SET_ACTIVITY_AREAS', response.data.activity_areas, { root: true })
            commit('docTag/SET_DOC_TAGS', response.data.doc_tags, { root: true })
            resolve(response)
          }
        })
      })
    },
    getDocumentForEdit({ commit }, documentId) {
      return new Promise((resolve, reject) => {
        axios.get(`api/v1/documents/${documentId}/edit`).then(response => {
          if (response.status == 200) {
            commit('SET_AVAILABLE_DOCUMENT_STATE_VALUES', response.data.available_document_state_values)
            commit('SET_AVAILABLE_DOCUMENT_KIND_VALUES', response.data.available_document_kind_values)
            commit('SET_DOCUMENT', response.data.document)
            commit('activityArea/SET_ACTIVITY_AREAS', response.data.activity_areas, { root: true })
            commit('docTag/SET_DOC_TAGS', response.data.doc_tags, { root: true })
            commit('documentFile/SET_DOCUMENT_FILE', response.data.document_file, { root: true })
            commit('initialOrder/SET_INITIAL_ORDER', response.data.initial_order || {}, { root: true })
            resolve(response)
          }
        })
      })
    },
    createDocument({ commit }, params) {
      return new Promise((resolve, reject) => {
        axios.post(`api/v1/documents`, params)
          .then(response => {
            if (response.status == 200) {
              commit('SET_DOCUMENT', {})
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
    updateDocument({ commit }, { params, documentId }) {
      return new Promise((resolve, reject) => {
        axios.patch(`api/v1/documents/${documentId}`, params)
          .then(response => {
            if (response.status == 200) {
              commit('SET_DOCUMENT', {})
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
    deleteDocument({ commit }, documentId) {
      return new Promise((resolve, reject) => {
        axios.delete(`api/v1/documents/${documentId}`).then(response => {
          if (response.status == 200) {
            commit('SET_DOCUMENT', {})
            resolve(response)
          }
        })
      })
    }
  },
  getters: {
    getDocumentVersionsCreatedAt: (state) => (index) => {
      return Vue.prototype
        .$dayjs(state.documentVersions[index].created_at)
        .format('DD.MM.YYYY H:mm')
    }
  }
}
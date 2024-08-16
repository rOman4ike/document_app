import Vue from "vue"
import axios from 'axios'

export const documentFileStore = {
  state: {
    documentFile: {},
    documentFiles: [],
  },
  mutations: {
    SET_DOCUMENT_FILE_PROPERTY(state, { key, value }) {
      Vue.set(state.documentFile, key, value)
    },
    SET_DOCUMENT_FILE(state, documentFile) {
      Vue.set(state, 'documentFile', documentFile)
    },
    SET_DOCUMENT_FILES(state, documentFiles) {
      Vue.set(state, 'documentFiles', documentFiles)
    },
  },
  actions: {
    deleteDocumentFile({ commit }, documentFileId) {
      return new Promise((resolve, reject) => {
        axios.delete(`api/v1/document_files/${documentFileId}`).then(response => {
          if (response.status == 200) {
            resolve(response)
          }
        })
      })
    }
  },
  getters: {
    getDocumentFileDeletedAt: (state) => (index) => {
      return Vue.prototype
        .$dayjs(state.documentFiles[index].deleted_at)
        .format('DD.MM.YYYY H:mm')
    }
  }
}
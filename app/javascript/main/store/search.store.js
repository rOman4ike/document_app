import Vue from "vue"
import axios from 'axios'

const INITIAL_SEARCH = {
  doc_tags: [],
  activity_areas: [],
  document_kinds: [],
  document_states: [],
}

export const searchStore = {
  state: {
    search: {
      doc_tags: [],
      activity_areas: [],
      document_kinds: [],
      document_states: [],
    },
  },
  mutations: {
    SET_SEARCH_PROPERTY(state, { key, value }) {
      Vue.set(state.search, key, value)
    },
    SET_SEARCH(state, search) {
      Vue.set(state, 'search', search)
    },
    SET_INITIAL_SEARCH(state) {
      Vue.set(state, 'search', INITIAL_SEARCH)
    }
  },
  getters: {
    createQuery(state) {
      const query = {
        title: state.search.title,
        doc_tags: state.search.doc_tags?.map((doc_tag) => doc_tag.value) || state.search.doc_tags,
        activity_areas: state.search.activity_areas,
        document_kinds: state.search.document_kinds,
        document_states: state.search.document_states,
        initial_date: state.search.initial_date
      }

      return query
    }
  }
}
<template>
  <div class="page">
    <header class="page-header">
      <h1 class="page-header__title">
        Нормативные документы
      </h1>
      <div class="page-header__actions">
        <router-link
          class="btn btn--primary"
          :to="{ name: 'document_new' }"
        >
          Добавить документ
        </router-link>
      </div>
    </header>

    <document-search-form @submit="onSubmitForm"/>

    <div class="page__content">
      <document-filter
        class="page__aside"
        v-if="isLoaded"
        @submit="onSubmitForm"
      />
      <div class="page__main">
        <ul
          class="list"
          v-if="documents.length"
        >
          <li
            class="list__item"
            v-for="document in documents"
            :key="document.id"
          >
            <document-card
              :document="document"
              @submit="onSubmitForm"
            />
          </li>
        </ul>
        <app-paginate
          class="page__paginate"
          v-if="documentPagination.pages > 1"
          :pages="documentPagination.pages"
          :max-pages="5"
          :current="documentPagination.page"
          @change-page="onChangePage"
        />
      </div>
    </div>

  </div>
</template>

<script>
import { mapActions, mapState, mapMutations, mapGetters } from "vuex"
import DocumentFilter from '@/main/components/DocumentFilter'
import DocumentCard from '@/main/components/DocumentCard'
import DocumentSearchForm from '@/main/components/DocumentSearchForm'
import AppPaginate from '@/commons/components/AppPaginate'

export default {
  components: {
    DocumentFilter,
    DocumentCard,
    DocumentSearchForm,
    AppPaginate,
  },
  data() {
    return {
      page: this.$route.query.page || 1,
      isLoaded: false
    }
  },
  computed: {
    ...mapState("document", [
      'documentPagination',
      'documents'
    ]),
    ...mapState('docTag', ['docTags']),
    ...mapState('search', ['search']),
    ...mapGetters('search', ['createQuery']),
  },
  created() {
    const params = JSON.parse(JSON.stringify(this.$route.query))
    this.getDocuments(params).then(_ => {
      const search = JSON.parse(JSON.stringify(this.$route.query))
      search.doc_tags = this.docTags.filter((docTag) => {
        if (typeof search.doc_tags == 'string') {
          return docTag.value == search.doc_tags
        } else {
          return search.doc_tags?.find((docTagId) => {
            return docTag.value == docTagId
          })
        }
      })
      search.activity_areas = [search.activity_areas].flat().filter(Boolean)
      search.document_states = [search.document_states].flat().filter(Boolean)
      search.document_kinds = [search.document_kinds].flat().filter(Boolean)
      this.isLoaded = true
      this.SET_SEARCH(search)
    })
  },
  destroyed() {
    this.SET_INITIAL_SEARCH()
  },
  watch: {
    '$route.query'(query) {
      this.page = query.page
      const params = query
      this.getDocuments(params)
    }
  },
  methods: {
    ...mapActions("document", ["getDocuments"]),
    ...mapMutations("search", [
      "SET_SEARCH",
      "SET_INITIAL_SEARCH"
    ]),
    onChangePage(page) {
      this.$router
        .replace({ query: { ...this.$route.query, page } })
        .catch(() => {})
    },
    onSubmitForm() {
      this.$router
        .replace({ query: this.createQuery })
        .catch(() => {})
    }
  },
};
</script>

<style></style>

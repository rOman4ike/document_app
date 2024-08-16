<template>
  <div class="page">
    <header class="page-header">
      <h1 class="page-header__title">
        Справочник ключевых слов
      </h1>
      <div class="page-header__actions">
        <button
          class="btn btn--primary"
          @click="onNewDocTag"
        >
          Добавить
        </button>
      </div>
    </header>

    <directory-search-form @submit="onSubmitForm"/>

    <div class="table">
      <table class="table__inner">
        <thead class="table__thead">
          <tr>
            <th class="table__th table__th--full-width">
              Ключевые слова
            </th>
            <th class="table__th">
              Действия
            </th>
          </tr>
        </thead>
        <tbody v-if="docTags.length">
          <tr
            v-for="docTag in docTags"
            :key="docTag.id"
          >
            <td class="table__td table__td--full-width">
              {{ docTag.title }}
            </td>
            <td class="table__td">
              <button
                class="icon icon--edit"
                @click="onEditDocTag(docTag)"
              >
              </button>
              <button
                class="icon icon--delete"
                @click="onDeleteDocTag(docTag.id)"
              >
              </button>
            </td>
          </tr>
        </tbody>
      </table>
      <app-paginate
        class="page__paginate"
        v-if="docTagPagination.pages > 1"
        :pages="docTagPagination.pages"
        :max-pages="5"
        :current="docTagPagination.page"
        @change-page="onChangePage"
      />
    </div>

    <app-errors
      :errors="errors.doc_tag.base"
      v-if="errors.doc_tag?.base?.length"
    />

    <app-modal
      v-if="isShowedModal"
      @close="onCloseModal"
    >
      <doc-tag-form
        :http-method="httpMethod"
        @close="onCloseModal"
      />
    </app-modal>
  </div>
</template>

<script>
import { mapState, mapActions, mapMutations } from 'vuex'
import AppModal from '@/commons/components/AppModal'
import AppErrors from '@/commons/components/AppErrors'
import DocTagForm from '@/directory/components/DocTagForm'
import DirectorySearchForm from '@/directory/components/DirectorySearchForm'
import AppPaginate from '@/commons/components/AppPaginate'

export default {
  components: {
    AppModal,
    AppErrors,
    DocTagForm,
    DirectorySearchForm,
    AppPaginate
  },
  data() {
    return {
      isShowedModal: false,
      httpMethod: ''
    }
  },
  computed: {
    ...mapState('docTag', [
      'docTags',
      'docTagPagination'
    ]),
    ...mapState('error', ['errors']),
  },
  watch: {
    '$route.query'(query) {
      const params = query
      this.getDocTags(params)
    }
  },
  created() {
    const params = JSON.parse(JSON.stringify(this.$route.query))
    this.SET_SEARCH(params)
    this.getDocTags(params)
  },
  destroyed() {
    this.SET_INITIAL_SEARCH()
  },
  methods: {
    ...mapActions('docTag', [
      'getDocTags',
      'deleteDocTag'
    ]),
    ...mapMutations("search", [
      "SET_SEARCH",
      "SET_INITIAL_SEARCH"
    ]),
    onCloseModal() {
      this.httpMethod = ''
      this.isShowedModal = false
      this.$store.commit('docTag/SET_DOC_TAG', {})
      this.$store.commit('error/SET_ERRORS', {})
    },
    onNewDocTag() {
      this.httpMethod = 'create'
      this.isShowedModal = true
      this.$store.commit('docTag/SET_DOC_TAG', {})
    },
    onEditDocTag(docTag) {
      this.httpMethod = 'update'
      this.isShowedModal = true
      const copyDocTag = JSON.parse(JSON.stringify(docTag))
      this.$store.commit('docTag/SET_DOC_TAG', copyDocTag)
    },
    onDeleteDocTag(docTagId) {
      this.deleteDocTag(docTagId).then(_ => {
        const params = JSON.parse(JSON.stringify(this.$route.query))
        this.getDocTags(params)
      })
    },
    onSubmitForm(params) {
      this.$router
        .replace({ query: params })
        .catch(() => {})
    },
    onChangePage(page) {
      this.$router
        .replace({ query: { ...this.$route.query, page } })
        .catch(() => {})
    },
  }
}
</script>
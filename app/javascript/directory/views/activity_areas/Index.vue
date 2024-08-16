<template>
  <div class="page">
    <header class="page-header">
      <h1 class="page-header__title">
        Справочник направлений деятельности
      </h1>
      <div class="page-header__actions">
        <button
          class="btn btn--primary"
          @click="onNewActivityArea"
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
              Направления деятельности
            </th>
            <th class="table__th">
              Действия
            </th>
          </tr>
        </thead>
        <tbody v-if="activityAreas.length">
          <tr
            v-for="activityArea in activityAreas"
            :key="activityArea.id"
          >
            <td class="table__td table__td--full-width">
              {{ activityArea.title }}
            </td>
            <td class="table__td">
              <button
                class="icon icon--edit"
                @click="onEditActivityArea(activityArea)"
              >
              </button>
              <button
                class="icon icon--delete"
                @click="onDeleteActivityArea(activityArea.id)"
              >
              </button>
            </td>
          </tr>
        </tbody>
      </table>
      <app-paginate
        class="page__paginate"
        v-if="activityAreaPagination.pages > 1"
        :pages="activityAreaPagination.pages"
        :max-pages="5"
        :current="activityAreaPagination.page"
        @change-page="onChangePage"
      />
    </div>

    <app-errors
      :errors="errors.activity_area?.base"
      v-if="errors.activity_area?.base?.length"
    />

    <app-modal
      v-if="isShowedModal"
      @close="onCloseModal"
    >
      <activity-area-form
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
import ActivityAreaForm from '@/directory/components/ActivityAreaForm'
import DirectorySearchForm from '@/directory/components/DirectorySearchForm'
import AppPaginate from '@/commons/components/AppPaginate'

export default {
  components: {
    AppModal,
    AppErrors,
    ActivityAreaForm,
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
    ...mapState('activityArea', [
      'activityAreas',
      'activityAreaPagination'
    ]),
    ...mapState('error', ['errors']),
  },
  watch: {
    '$route.query'(query) {
      const params = query
      this.getActivityAreas(params)
    }
  },
  created() {
    const params = JSON.parse(JSON.stringify(this.$route.query))
    this.SET_SEARCH(params)
    this.getActivityAreas(params)
  },
  destroyed() {
    this.SET_INITIAL_SEARCH()
  },
  methods: {
    ...mapActions('activityArea', [
      'getActivityAreas',
      'deleteActivityArea'
    ]),
    ...mapMutations("search", [
      "SET_SEARCH",
      "SET_INITIAL_SEARCH"
    ]),
    onCloseModal() {
      this.httpMethod = ''
      this.isShowedModal = false
      this.$store.commit('activityArea/SET_ACTIVITY_AREA', {})
      this.$store.commit('error/SET_ERRORS', {})
    },
    onNewActivityArea() {
      this.httpMethod = 'create'
      this.isShowedModal = true
      this.$store.commit('activityArea/SET_ACTIVITY_AREA', {})
    },
    onEditActivityArea(activityArea) {
      this.httpMethod = 'update'
      this.isShowedModal = true
      const copyActivityArea = JSON.parse(JSON.stringify(activityArea))
      this.$store.commit('activityArea/SET_ACTIVITY_AREA', copyActivityArea)
    },
    onDeleteActivityArea(activityAreaId) {
      this.deleteActivityArea(activityAreaId).then(_ => {
        const params = JSON.parse(JSON.stringify(this.$route.query))
        this.getActivityAreas(params)
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
<template>
  <form
    class="form form--bg"
    @submit.prevent="onSubmitForm"
  >
    <app-input
      class="form__group"
      v-model.trim="searchTitle"
      label="Поиск"
    />

    <app-select-multiple
      class="form__group"
      v-model="searchDocTags"
      label="Ключевые слова"
      :options="docTags"
    />

    <div class="form__actions">
      <button class="btn btn--primary">
        Найти
      </button>
      <button
        class="link link--with-icon"
        type="button"
        @click="onCleanSearch"
      >
        <span class="icon icon--clean">
        </span>
        Очистить
      </button>
    </div>
  </form>
</template>

<script>
import { mapFields } from '@/commons/helpers/mapFields'
import { mapState, mapActions, mapMutations } from "vuex"
import AppInput from '@/commons/components/Form/AppInput'
import AppSelect from '@/commons/components/Form/AppSelect'
import AppSelectMultiple from '@/commons/components/Form/AppSelectMultiple'

export default {
  components: {
    AppInput,
    AppSelect,
    AppSelectMultiple
  },
  data() {
    return { }
  },
  computed: {
    ...mapFields('search', 'search', 'SET_SEARCH_PROPERTY', {
      searchTitle: 'title',
      searchDocTags: 'doc_tags',
    }),
    ...mapState('docTag', ['docTags']),
    ...mapState('search', ['search']),
  },
  methods: {
    ...mapMutations("search", [
      "SET_SEARCH",
      "SET_INITIAL_SEARCH"
    ]),
    onCleanSearch() {
      this.searchTitle = undefined
      this.searchDocTags = []
      this.$emit('submit')
    },
    onSubmitForm() {
      this.$emit('submit')
    }
  }
}
</script>
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
    }),
  },
  methods: {
    ...mapMutations("search", ["SET_SEARCH"]),
    onCleanSearch() {
      this.searchTitle = undefined
      this.$emit('submit')
    },
    onSubmitForm() {
      const params = {
        title: this.searchTitle
      }
      this.$emit('submit', params)
    }
  }
}
</script>
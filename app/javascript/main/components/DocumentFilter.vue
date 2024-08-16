<template>
  <aside>
    <h2>
      Фильтры
    </h2>

    <ul class="filter">
      <li
        class="filter__attribute filter__attribute--dropdown"
        v-if="activityAreas.length"
      >
        <app-dropdown
          class="dropdown--filter"
          title="Направления деятельности"
          :is-open="Boolean(searchActivityAreas.length)"
        >
          <app-checkbox-group
            name="activity_area"
            v-model="searchActivityAreas"
            :options="activityAreas"
            @input="onChange"
          />
        </app-dropdown>
      </li>

      <li
        class="filter__attribute filter__attribute--dropdown"
        v-if="availableDocumentKindValues.length"
      >
        <app-dropdown
          class="dropdown--filter"
          title="Категория документа"
          :is-open="Boolean(searchDocumentKinds.length)"
        >
          <app-checkbox-group
            v-model="searchDocumentKinds"
            name="document_kind"
            :options="availableDocumentKindValues"
            @input="onChange"
          />
        </app-dropdown>
      </li>

      <li
        class="filter__attribute filter__attribute--dropdown"
        v-if="availableDocumentStateValues.length"
      >
        <app-dropdown
          class="dropdown--filter"
          title="Статус документа"
          :is-open="Boolean(searchDocumentStates.length)"
        >
          <app-checkbox-group
            v-model="searchDocumentStates"
            name="document_kind"
            :options="availableDocumentStateValues"
            @input="onChange"
          />
        </app-dropdown>
      </li>

      <li class="filter__attribute">
        <p class="filter__name">
          Год введения в действие
        </p>
        <app-input
          v-model.trim="searchDocumentYear"
          @keyup="onChange"
        />
      </li>

      <li class="filter__actions">
        <button
          class="btn btn--primary"
          @click="onShowSearch"
        >
          Сбросить
        </button>
      </li>
    </ul>
  </aside>
</template>

<script>
import { mapActions, mapState } from 'vuex'
import { mapFields } from '@/commons/helpers/mapFields'
import AppCheckboxGroup from '@/commons/components/Form/AppCheckboxGroup'
import AppInput from '@/commons/components/Form/AppInput'
import AppDropdown from '@/commons/components/AppDropdown'

export default {
  components: {
    AppCheckboxGroup,
    AppInput,
    AppDropdown
  },
  data() {
    return { }
  },
  computed: {
    ...mapState('document', [
      'availableDocumentStateValues',
      'availableDocumentKindValues',
    ]),
    ...mapState('activityArea', ['activityAreas']),
    ...mapState('docTag', ['docTags']),
    ...mapState('search', ['search']),
    ...mapFields('search', 'search', 'SET_SEARCH_PROPERTY', {
      searchActivityAreas: 'activity_areas',
      searchDocumentKinds: 'document_kinds',
      searchDocumentStates: 'document_states',
      searchDocumentYear: 'initial_date',
    }),
  },
  methods: {
    onShowSearch() {
      this.searchActivityAreas = []
      this.searchDocumentKinds = []
      this.searchDocumentStates = []
      this.searchDocumentYear = undefined
      this.$emit('submit')
    },
    onChange() {
      this.$emit('submit')
    }
  }
}
</script>
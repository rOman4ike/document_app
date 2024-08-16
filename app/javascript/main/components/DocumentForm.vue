<template>
  <form
    class="form"
    @submit.prevent="onSubmitForm"
  >
    <app-input
      class="form__group"
      v-model.trim="documentTitle"
      label="Наименование документа"
      required
      :errors="errors.document?.title"
    />

    <div class="form__group form__group--row">
      <app-select-multiple
        v-model="documentActivityAreas"
        label="Направление деятельности"
        required
        :options="activityAreas"
        :errors="errors.document?.document_activity_areas"
      />
    </div>

    <div class="form__group form__group--row">
      <app-select
        v-model="documentState"
        label="Статус документа"
        required
        :options="availableDocumentStateValues"
        :errors="errors.document?.state"
      />
      <app-select
        v-model="documentKind"
        label="Категория документа"
        required
        :options="availableDocumentKindValues"
        :errors="errors.document?.kind"
      />
    </div>

    <app-select-multiple
      class="form__group"
      v-model="documentDocTags"
      label="Ключевые слова"
      required
      :options="docTags"
      :errors="errors.document?.document_doc_tags"
    />

    <app-file
      class="form__group"
      v-model="documentFileFile"
      label="Файл документа"
      required
      :errors="errors.document_file?.file || errors.document?.document_files"
      :file-url="documentFile.url"
    />

    <app-checkbox
      class="form__group"
      v-model="isInitialOrderRequired"
      v-if="!isInitialOrderHave"
    >
      Есть приказ о введении в действие
      <span
        class="icon icon--question icon--sm"
        v-tooltip="'Выберите, если документ имеет приказ о вводе в действие.'"
      ></span>
    </app-checkbox>

    <initial-order-form
      class="form__group"
      v-if="isInitialOrderRequired"
    />

    <app-checkbox
      class="form__group"
      v-model="isChangeOrderRequired"
      v-if="isInitialOrderHave"
    >
      Есть приказ о внесении в изменений
      <span
        class="icon icon--question icon--sm"
        v-tooltip="'Выберите, если документ имеет приказ о вводе в действие.'"
      ></span>
    </app-checkbox>

    <change-order-form
      class="form__group"
      v-if="isChangeOrderRequired"
    />

    <div class="form__actions">
      <button class="btn btn--primary">
        Сохранить
      </button>
      <router-link
        class="btn btn--outline-primary"
        :to="{ name: 'document_index' }"
      >
        Отмена
      </router-link>
    </div>
  </form>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex'
import { mapFields } from '@/commons/helpers/mapFields'
import { buildFormData, mergeFormData } from '@/commons/helpers/buildFormData'
import InitialOrderForm from '@/main/components/InitialOrderForm'
import ChangeOrderForm from '@/main/components/ChangeOrderForm'
import AppCheckbox from '@/commons/components/Form/AppCheckbox'
import AppFile from '@/commons/components/Form/AppFile'
import AppInput from '@/commons/components/Form/AppInput'
import AppSelect from '@/commons/components/Form/AppSelect'
import AppSelectMultiple from '@/commons/components/Form/AppSelectMultiple'

export default {
  components: {
    InitialOrderForm,
    ChangeOrderForm,
    AppCheckbox,
    AppFile,
    AppInput,
    AppSelect,
    AppSelectMultiple,
  },
  data() {
    return {
      routeName: this.$route.name,
      documentId: this.$route.params.id,
      isInitialOrderHave: false,
      isInitialOrderRequired: false,
      isChangeOrderRequired: false,
    }
  },
  computed: {
    ...mapState('config', ['user']),
    ...mapState('error', ['errors']),
    ...mapState('document', [
      'document',
      'availableDocumentStateValues',
      'availableDocumentKindValues',
    ]),
    ...mapState('activityArea', ['activityAreas']),
    ...mapState('initialOrder', ['initialOrder']),
    ...mapState('changeOrder', ['changeOrder']),
    ...mapState('docTag', ['docTags']),
    ...mapState('documentFile', ['documentFile']),
    ...mapFields('document', 'document', 'SET_DOCUMENT_PROPERTY', {
      documentTitle: 'title',
      documentKind: 'kind',
      documentState: 'state',
      documentActivityAreas: 'document_activity_areas',
      documentDocTags: 'document_doc_tags',
    }),
    ...mapFields('documentFile', 'documentFile', 'SET_DOCUMENT_FILE_PROPERTY', {
      documentFileFile: 'file',
    }),
  },
  watch: {
    '$route'(to) {
      this.documentId = to.params.id
      this.getDocumentForEdit(this.documentId)
    }
  },
  created() {
    if (this.routeName == 'document_new') {
      this.getDocumentForCreate().then(_ => {
        this.SET_INITIAL_INITIAL_ORDER()
      })
    } else if (this.routeName == 'document_edit') {
      this.getDocumentForEdit(this.documentId).then(_ => {
        this.isInitialOrderHave = Boolean(this.initialOrder.id)
        this.isInitialOrderRequired = Boolean(this.initialOrder.id)
        if (!this.isInitialOrderHave) this.SET_INITIAL_INITIAL_ORDER()
        this.SET_INITIAL_CHANGE_ORDER()
      })
    }
  },
  destroyed() {
    this.$store.commit('document/SET_DOCUMENT', {})
    this.$store.commit('documentFile/SET_DOCUMENT_FILE', {})
    this.$store.commit('initialOrder/SET_INITIAL_INITIAL_ORDER', {})
    this.$store.commit('changeOrder/SET_INITIAL_CHANGE_ORDER', {})
    this.$store.commit('error/SET_ERRORS', {})
  },
  methods: {
    ...mapMutations('initialOrder', ['SET_INITIAL_INITIAL_ORDER']),
    ...mapMutations('changeOrder', ['SET_INITIAL_CHANGE_ORDER']),
    ...mapActions('document', [
      'getDocumentForCreate',
      'getDocumentForEdit',
      'createDocument',
      'updateDocument'
    ]),
    appendDictionaryItemToParams(params, modelName, item) {
      params.append(`document[document_${modelName}s_attributes][][${modelName}_id]`, item.value)
      if (item.id) params.append(`document[document_${modelName}s_attributes][][id]`, item.id)
      if (item._destroy) params.append(`document[document_${modelName}s_attributes][][_destroy]`, true)
    },
    onSubmitForm() {
      const documentParams = buildFormData(new FormData(), this.document, 'document', true)
      this.documentActivityAreas?.forEach(this.appendDictionaryItemToParams.bind(null, documentParams, 'activity_area'))
      this.documentDocTags?.forEach(this.appendDictionaryItemToParams.bind(null, documentParams, 'doc_tag'))
      const documentFileParams = buildFormData(new FormData(), this.documentFile, 'document[document_files_attributes][]', true)
      const initialOrderParams = buildFormData(new FormData(), this.initialOrder, 'document[initial_orders_attributes][]', true)
      const changeOrderParams = buildFormData(new FormData(), this.changeOrder, 'document[change_orders_attributes][]', true)
      let params = mergeFormData(documentParams, documentFileParams)
      if (this.isInitialOrderRequired) params = mergeFormData(params, initialOrderParams)
      if (this.isChangeOrderRequired) params = mergeFormData(params, changeOrderParams)
      params.append('document[is_initial_order_required]', this.isInitialOrderRequired)
      params.append('document[is_change_order_required]', this.isChangeOrderRequired)
      params.delete('document[document_activity_areas]')
      params.delete('document[document_doc_tags]')
      params.delete('document[document_files_attributes][][url]')
      params.delete('document[initial_orders_attributes][][url]')
      if (this.routeName == 'document_new') {
        params.append('document[user_id]', this.user.id)
        this.createDocument(params).then(_ => {
          this.$router.replace({ name: 'document_index' })
        })
      } else {
        const documentId = this.documentId
        this.updateDocument({ params, documentId }).then(_ => {
          this.$router.replace({ name: 'document_index' })
        })
      }
    }
  }
}
</script>
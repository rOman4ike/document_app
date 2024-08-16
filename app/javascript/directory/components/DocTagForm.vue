<template>
  <form
    class="form"
    @submit.prevent="onSubmitForm"
  >
    <h2>
      Добавление ключевого слова
    </h2>
    <app-input
      class="form__group"
      label="Ключевое слово"
      v-model.trim="docTagTitle"
      :errors="errors.doc_tag?.title"
    />
    <div class="form__actions">
      <button class="btn btn--primary">
        Сохранить
      </button>
      <button
        class="btn btn--outline-primary"
        type="button"
        @click="onClose"
      >
        Отмена
      </button>
    </div>
  </form>
</template>

<script>
import { mapState, mapActions } from 'vuex'
import { mapFields } from '@/commons/helpers/mapFields'
import { buildFormData } from '@/commons/helpers/buildFormData'
import AppInput from '@/commons/components/Form/AppInput'

export default {
  components: {
    AppInput,
  },
  props: {
    httpMethod: {
      type: String,
      required: true
    }
  },
  data() {
    return { }
  },
  computed: {
    ...mapState('docTag', ['docTag']),
    ...mapState('error', ['errors']),
    ...mapFields('docTag', 'docTag', 'SET_DOC_TAG_PROPERTY', {
      docTagTitle: 'title',
    }),
  },
  methods: {
    ...mapActions('docTag', [
      'getDocTags',
      'createDocTag',
      'updateDocTag',
    ]),
    onSubmitForm() {
      const params = buildFormData(new FormData(), this.docTag, 'doc_tag')
      if (this.httpMethod == 'create') {
        this.createDocTag(params).then(_ => {
          this.getDocTags().then(_ => {
            this.$emit('close')
          })
        })
      } else if (this.httpMethod == 'update') {
        const docTagId = params.get('doc_tag[id]')
        this.updateDocTag({ params, docTagId }).then(_ => {
          this.getDocTags().then(_ => {
            this.$emit('close')
          })
        })
      }
    },
    onClose() {
      this.$emit('close')
    }
  },
}
</script>
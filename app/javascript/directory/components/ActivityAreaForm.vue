<template>
  <form
    class="form"
    @submit.prevent="onSubmitForm"
  >
    <h2>
      Добавление направления деятельности
    </h2>
    <app-input
      class="form__group"
      label="Направление деятельности"
      v-model.trim="activityAreaTitle"
      :errors="errors.activity_area?.title"
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
    AppInput
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
    ...mapState('error', ['errors']),
    ...mapState('activityArea', ['activityArea']),
    ...mapFields('activityArea', 'activityArea', 'SET_ACTIVITY_AREA_PROPERTY', {
      activityAreaTitle: 'title',
    }),
  },
  methods: {
    ...mapActions('activityArea', [
      'getActivityAreas',
      'createActivityArea',
      'updateActivityArea',
    ]),
    onSubmitForm() {
      const params = buildFormData(new FormData(), this.activityArea, 'activity_area')
      if (this.httpMethod == 'create') {
        this.createActivityArea(params).then(_ => {
          this.getActivityAreas().then(_ => {
            this.$emit('close')
          })
        })
      } else if (this.httpMethod == 'update') {
        const activityAreaId = params.get('activity_area[id]')
        this.updateActivityArea({ params, activityAreaId }).then(_ => {
          this.getActivityAreas().then(_ => {
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
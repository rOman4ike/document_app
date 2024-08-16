<template>
  <div>
    <fieldset class="form__fieldset">
      <h2>
        Приказ о введении в действие
      </h2>

      <div class="form__group form__group--row">
        <app-input
          v-model.trim="initialOrderNumber"
          label="Номер приказа"
          required
          :errors="errors.initial_order?.number"
        />
        <app-date
          v-model="initialOrderInitialDate"
          label="Дата приказа"
          required
          :errors="errors.initial_order?.initial_date"
        />
      </div>

      <app-file
        class="form__group"
        v-model="initialOrderFile"
        label="Файл документа"
        required
        :errors="errors.initial_order?.file"
        :file-url="initialOrder.url"
      />
    </fieldset>
  </div>
</template>

<script>
import { mapState } from 'vuex'
import { mapFields } from '@/commons/helpers/mapFields'
import AppFile from '@/commons/components/Form/AppFile'
import AppInput from '@/commons/components/Form/AppInput'
import AppDate from '@/commons/components/Form/AppDate'

export default {
  components: {
    AppFile,
    AppInput,
    AppDate
  },
  data() {
    return { }
  },
  computed: {
    ...mapState('error', ['errors']),
    ...mapState('initialOrder', ['initialOrder']),
    ...mapFields('initialOrder', 'initialOrder', 'SET_INITIAL_ORDER_PROPERTY', {
      initialOrderNumber: 'number',
      initialOrderInitialDate: 'initial_date',
      initialOrderFile: 'file',
    })
  }
}
</script>
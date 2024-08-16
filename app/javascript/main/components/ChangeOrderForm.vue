<template>
  <div>
    <fieldset class="form__fieldset">
      <h2>
        Приказ о внесении изменений
      </h2>

      <div class="form__group form__group--row">
        <app-input
          v-model.trim="changeOrderNumber"
          label="Номер приказа"
          required
          :errors="errors.change_order?.number"
        />
        <app-date
          v-model="changeOrderChangeDate"
          label="Дата приказа"
          required
          :errors="errors.change_order?.change_date"
        />
      </div>

      <app-file
        class="form__group"
        v-model="changeOrderFile"
        label="Файл документа"
        required
        :errors="errors.change_order?.file"
        :file-url="changeOrder.file?.url"
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
    ...mapState('changeOrder', ['changeOrder']),
    ...mapFields('changeOrder', 'changeOrder', 'SET_CHANGE_ORDER_PROPERTY', {
      changeOrderNumber: 'number',
      changeOrderChangeDate: 'change_date',
      changeOrderFile: 'file',
    })
  }
}
</script>
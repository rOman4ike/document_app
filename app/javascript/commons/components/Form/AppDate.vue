<template>
  <div>
    <label
      class="label"
      :class="{ 'label--required': required }"
    >
      {{ label }}
    </label>
    <div
      class="input-datepicker"
      :class="{ 'input-datepicker--errors': errors.length }"
    >
      <datepicker
        :language="ru"
        :monday-first='true'
        :input-class="{
          'input-datepicker__field': true,
          'form__field--error': errors.length
        }"
        :value="value"
        :placeholder="placeholder"
        @input="onInput"
      >
      </datepicker>
      <app-errors
        :errors="errors"
        v-if="errors.length"
      />
    </div>
  </div>
</template>

<script>
import AppErrors from '@/commons/components/AppErrors'
import Datepicker from 'vuejs-datepicker'
import { ru } from 'vuejs-datepicker/dist/locale'

export default {
  components: {
    AppErrors,
    Datepicker
  },
  props: {
    label: {
      type: String,
      default: ''
    },
    required: {
      type: Boolean,
      default: false
    },
    errors: {
      type: Array,
      default: () => []
    },
    value: {
      type: [String, Date],
      default: ''
    },
    placeholder: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      ru: ru
    }
  },
  methods: {
    onInput(value) {
      this.$emit('input', value)
    }
  }
}
</script>
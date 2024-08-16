<template>
  <ul class="checkbox-group">
    <li
      class="checkbox-group__item"
      v-for="option in options"
    >
      <app-checkbox
        v-model="value"
        :option="option"
        :name="name"
        :checked="isChecked(option)"
        @input="onChange"
      >
        {{ option.text }}
      </app-checkbox>
    </li>
  </ul>
</template>

<script>
import AppCheckbox from '@/commons/components/Form/AppCheckbox'

export default {
  components: {
    AppCheckbox
  },
  props: {
    value: {
      type: Array,
      default: () => []
    },
    options: {
      type: Array,
      default: []
    },
    name: {
      type: String
    }
  },
  data() {
    return { }
  },
  methods: {
    onChange(event) {
      this.$emit('input', this.value)
    },
    isChecked(option) {
      return this.value.some((selectedValue) => {
        return selectedValue == option.value
      })
    }
  }
}
</script>
<template functional>
  <div :class="[data.class, data.staticClass]">
    <label
      class="label"
      :class="{ 'label--required': props.required }"
    >
      {{ props.label }}
    </label>
    <div
      class="input-text"
      :class="{ 'input-text--errors': props.errors.length }"
    >
      <input
        class="input-text__field"
        :class="{ 'form__field--error': props.errors.length }"
        :type="props.type"
        :value="props.value"
        :placeholder="props.placeholder"
        @input="listeners.input && listeners.input($event.target.value)"
      >
      <component
        :is="props.components.AppErrors"
        :errors="props.errors"
        v-if="props.errors.length"
      />
    </div>
  </div>
</template>

<script>
import AppErrors from '@/commons/components/AppErrors'

export default {
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
      type: String,
      default: ''
    },
    placeholder: {
      type: String,
      default: ''
    },
    type: {
      type: String,
      default: 'text'
    },
    components: {
      type: Object,
      default() {
        return {
          AppErrors
        }
      }
    }
  }
}
</script>
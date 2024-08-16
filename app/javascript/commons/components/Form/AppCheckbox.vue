<template>
  <div>
    <div class="input-checkbox">
      <div class="input-checkbox__inner">
        <input
          class="input-checkbox__field"
          type="checkbox"
          :checked="checked"
          :value="option?.value"
          :name="name"
          @input="onInput"
        >
        <span>
          <slot></slot>
        </span>
      </div>
      <app-errors
        :errors="errors"
        v-if="errors.length"
      />
    </div>
  </div>
</template>

<script>
import AppErrors from '@/commons/components/AppErrors'

export default {
  components: {
    AppErrors
  },
  props: {
    required: {
      type: Boolean,
      default: false
    },
    errors: {
      type: Array,
      default: () => []
    },
    option: {
      type: Object,
    },
    value: {
      type: [Boolean, Array],
    },
    checked: {
      type: Boolean,
      default: false
    },
    name: String
  },
  data() {
    return { }
  },
  methods: {
    onInput(event) {
      if (typeof this.value == 'boolean') {
        this.$emit('input', Boolean(event.target.checked))
      } else {
        if (Boolean(event.target.checked)) {
          this.value.push(event.target.value)
        } else {
          const index = this.value.indexOf(event.target.value)
          this.value.splice(index, 1)
        }
        this.$emit('input', this.value)
      }
    }
  }
}
</script>
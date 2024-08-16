<template>
  <div>
    <label
      class="label"
      :class="{ 'label--required': required }"
    >
      {{ label }}
    </label>
    <div
      class="input-file"
      :class="{ 'input-file--errors': errors.length }"
    >
      <div>
        <span class="input-file__btn btn btn--primary">
          <span class="input-file__placeholder">
            Выбрать файл
          </span>
          <input
            class="input-file__field"
            type="file"
            @change="onChange"
          >
        </span>
        <span
          class="input-file__file"
          v-if="fileUrl || inputValue?.name"
        >
          <span>
            Текущий файл:
          </span>
          <span
            class="input-file__file-name"
            v-if="inputValue?.name"
          >
            "{{ inputValue?.name }}"
          </span>
          <a
            class="link"
            :href="fileUrl"
            target="_blank"
            v-else-if="fileUrl"
          >
            Скачать
          </a>
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
    fileUrl: {
      type: String,
      required: false
    },
    value: {
      type: File,
      default: () => {}
    },
  },
  data() {
    return {
      inputValue: this.value
    }
  },
  watch: {
    value(newValue) {
      this.inputValue = newValue
    }
  },
  methods: {
    onChange(event) {
      const file = event.target.files[0]
      this.$emit('input', file)
    }
  }
}
</script>
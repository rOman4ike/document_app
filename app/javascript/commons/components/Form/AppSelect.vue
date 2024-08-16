<template>
  <div>
    <label
      class="label"
      :class="{ 'label--required': required }"
    >
      {{ label }}
    </label>
    <div
      class="select"
      :class="{
        'select--selected': isOpenDropdown,
        'select--errors': errors.length
      }"
    >
      <button
        class="select__field"
        type="button"
        @mousedown="onToggleDropdown"
      >
        <span v-if="selectedOption.text">
          {{ selectedOption.text }}
        </span>
        <input
          class="select__search-field"
          v-else
          ref="search"
          :placeholder="placeholder"
          v-model.trim="search"
        />
      </button>
      <transition name="select-height">
        <ul
          class="select__options"
          v-if="filteredOptions.length && isOpenDropdown"
        >
          <li
            class="select__option"
            :class="{ 'select__option--selected': selectedOption.value == option.value }"
            v-for="option in filteredOptions"
            :key="option.value"
            @click="onSelectOption(option)"
            @mouseup="onSelectOption(option)"
          >
            {{ option.text }}
          </li>
        </ul>
        <ul
          class="select__options"
          v-else-if="!filteredOptions.length && isOpenDropdown"
        >
          Элементов нет или они не найдены
        </ul>
      </transition>
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
    options: {
      type: Array,
      default: () => []
    },
    errors: {
      type: Array,
      default: () => []
    },
    placeholder: {
      type: String,
      default: 'Выберите из списка'
    },
    value: {
      type: [String, Number],
      default: ''
    }
  },
  data() {
    return {
      selectedOption: {
        value: '',
        text: ''
      },
      isOpenDropdown: false,
      search: ''
    }
  },
  watch: {
    value(newValue) {
      this.selectedOption = JSON.parse(JSON.stringify(this.options.find(el => el.value == newValue) || {}))
    },
  },
  computed: {
    filteredOptions() {
      return this.options.filter((option) => {
        const isSearchable = this.search ? option.text.toLowerCase().includes(this.search.toLowerCase()) : true
        return isSearchable
      })
    },
  },
  mounted () {
    document.addEventListener('click', this.close)
  },
  beforeDestroy () {
    document.removeEventListener('click',this.close)
  },
  methods: {
    onSelectOption(option) {
      if (this.selectedOption.value == option.value) {
        this.selectedOption.value = ''
        this.selectedOption.text = ''
      } else {
        this.selectedOption.value = option.value
        this.selectedOption.text = option.text
      }
      this.isOpenDropdown = false
      this.search = ''
      this.$emit('input', this.selectedOption.value)
    },
    onToggleDropdown() {
      this.isOpenDropdown = !this.isOpenDropdown
    },
    close (e) {
      if (!this.$el.contains(e.target)) {
        this.isOpenDropdown = false
      }
    }
  }
}
</script>

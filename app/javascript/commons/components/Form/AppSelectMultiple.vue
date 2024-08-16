<template>
  <div>
    <label
      class="label"
      :class="{ 'label--required': required }"
    >
      {{ label }}
    </label>
    <div
      class="select-multiple"
      :class="{
        'select-multiple--selected': isOpenDropdown,
        'select-multiple--errors': errors.length
      }"
    >
      <button
        class="select-multiple__field"
        type="button"
        @mousedown="onToggleDropdown"
      >
        <ul
          class="select-multiple__selected-options"
        >
          <li
            class="select-multiple__selected-option tag"
            v-for="selectedOption in filteredSelectedOptions"
            :key="selectedOption.value"
            @mousedown="onRemoveOption(selectedOption.value)"
          >
            <span class="select-multiple__selected-text">
              {{ selectedOption.text }}
            </span>
            <span
              class="icon icon--delete-gray icon--xs"
            >
            </span>
          </li>
          <li class="select-multiple__search">
            <input
              class="select-multiple__search-field"
              ref="search"
              :placeholder="placeholder"
              v-model.trim="search"
            />
          </li>
        </ul>
      </button>
      <transition name="select-multiple-height">
        <ul
          class="select-multiple__options"
          v-if="filteredOptions.length && isOpenDropdown"
        >
          <li
            class="select-multiple__option"
            v-for="option in filteredOptions"
            :key="option.value"
            @mouseup="onSelectOption(option)"
          >
            {{ option.text || option.title }}
          </li>
        </ul>
        <ul
          class="select-multiple__options"
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
      default: 'Введите или выберите один или несколько вариантов'
    },
    value: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      selectedOptions: [],
      optionsCopy: [],
      isOpenDropdown: false,
      search: '',
    }
  },
  computed: {
    filteredOptions() {
      return this.options.filter((option) => {
        const isGetSelectedOption = !this.selectedOptions.some((selectedOption) => {
          return selectedOption.value == option.value &&
            !selectedOption._destroy
        })
        const isSearchable = this.search ? option.text.toLowerCase().includes(this.search.toLowerCase()) : true
        return isGetSelectedOption && isSearchable
      })
    },
    filteredSelectedOptions() {
      return this.selectedOptions.filter((selectedOption) => {
        return !selectedOption._destroy
      })
    }
  },
  mounted () {
    document.addEventListener('click', this.close)
  },
  beforeDestroy () {
    document.removeEventListener('click',this.close)
  },
  watch: {
    value(newValue) {
      this.selectedOptions = newValue
    },
  },
  methods: {
    onSelectOption(selectedOption) {
      this.$refs.search.focus()
      const savedOptionIndex = this.value.findIndex((option) => {
        return option.value == selectedOption.value
      })
      if (savedOptionIndex == -1) {
        this.selectedOptions.push(selectedOption)
      } else {
        this.$set(this.selectedOptions[savedOptionIndex], '_destroy', false)
      }
      this.search = ''
      this.$emit('input', this.selectedOptions)
    },
    onToggleDropdown() {
      this.isOpenDropdown = !this.isOpenDropdown
    },
    onRemoveOption(value) {
      const optionIndex = this.selectedOptions.findIndex((selectedOption) => {
        return selectedOption.value == value
      })
      if (this.selectedOptions[optionIndex].id) {
        this.$set(this.selectedOptions[optionIndex], '_destroy', true)
      } else {
        this.$delete(this.selectedOptions, optionIndex)
      }
      this.$emit('input', this.selectedOptions)
    },
    close (e) {
      if (!this.$el.contains(e.target)) {
        this.isOpenDropdown = false
      }
    }
  }
}
</script>
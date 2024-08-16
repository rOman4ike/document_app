<template>
  <div class="dropdown">
    <div
      class="dropdown__header"
      :class="{ 'dropdown__header--active': isOpenDropdown }"
      @click="onToggleDropdownBody"
    >
      {{ title }}
    </div>
    <div
      class="dropdown__body"
      v-if="isOpenDropdown"
    >
      <slot>
      </slot>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    title: String,
    isOpen: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      isOpenDropdown: this.isOpen
    }
  },
  methods: {
    onToggleDropdownBody() {
      this.isOpenDropdown = !this.isOpenDropdown
    }
  }
}
</script>
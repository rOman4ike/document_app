<template functional>
  <ul class="errors">
    <li
      class="errors__item"
      v-for="error in props.errors"
    >
      {{ error }}
    </li>
  </ul>
</template>

<script>
export default {
  props: {
    errors: {
      type: Array,
      default: () => []
    },
  },
}
</script>
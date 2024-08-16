<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import axios from "axios"

export default {
  methods: {
    onSignOut() {
      axios.delete('api/v1/sessions')
    }
  }
}
</script>
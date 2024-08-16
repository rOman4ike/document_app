<template>
  <div>
    <header>
      <nav>
        <router-link :to="{ name: 'sessions_sign_in' }">
          Sign In
        </router-link>
        <router-link :to="{ name: 'sessions_sign_up' }">
          Sign up
        </router-link>
        <a>
          Sign up
        </a>
      </nav>
    </header>

    <div>
      <router-view></router-view>
    </div>
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
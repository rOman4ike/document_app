<template>
  <div>
    <header>
      <h1>
        SignUp Form
      </h1>
    </header>

    <form @submit.prevent="onSubmitForm">
      <div>
        <input
          type="text"
          v-model.trim="userEmail"
        >
      </div>
      <div>
        <input
          type="password"
          v-model.trim="userPassword"
        >
      </div>
      <div>
        <input
          type="password"
          v-model.trim="userPasswordConfirmation"
        >
      </div>
      <button>
        Submit
      </button>
    </form>
  </div>
</template>

<script>
import { mapFields } from '@/commons/helpers/mapFields';
import { mapState, mapActions } from 'vuex'

export default {
  data() {
    return {

    }
  },
  computed: {
    ...mapState('user', ['user']),
    ...mapFields('user', 'user', 'SET_USER_PROPERTY', {
      userEmail: 'email',
      userPassword: 'password',
      userPasswordConfirmation: 'password_confirmation',
    })
  },
  methods: {
    ...mapActions('user', ['createUser']),
    onSubmitForm() {
      const params = {
        user: this.user
      }
      this.createUser(params)
    }
  }
}
</script>
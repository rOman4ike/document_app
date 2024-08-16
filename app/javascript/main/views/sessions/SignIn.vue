<template>
  <div>
    <header>
      <h1>
        SignIn Form
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
          type="text"
          v-model.trim="userPassword"
        >
      </div>
      <div>
        <input
          type="text"
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

export default {
  data() {
    return {

    }
  },
  computed: {
    ...mapFields('user', 'user', 'SET_USER_PROPERTY', {
      userEmail: 'email',
      userPassword: 'password',
      userPasswordConfirmation: 'password_confirmation',
    })
  },
  methods: {
    onSubmitForm() {
      console.log('yep');
    }
  }
}
</script>
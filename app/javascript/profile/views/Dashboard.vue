<template>
  <div class="container">
    <profile-form :type="formType"/>

    <hr>

    <div>
      <button
        class="btn btn--primary"
        v-if="formType != 'signin'"
        @click="formType = 'signin'"
      >
        Войти
      </button>
      <button
        class="btn btn--secondary"
        v-else
        @click="formType = 'signup'"
      >
        Регистрация
      </button>
    </div>
</div>
</template>

<script>
import ProfileForm from '@/profile/components/ProfileForm'

export default {
  components: {
    ProfileForm
  },
  data() {
    return {
      formType: 'register'
    }
  },
}
</script>

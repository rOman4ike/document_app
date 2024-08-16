<template>
  <div class="card">
    <div class="card-header">
      <h1>
        {{ type == 'signin' ? 'Вход' : 'Регистрация'}}
      </h1>
    </div>
    <form
      class="form"
      @submit.prevent="onSubmitForm"
    >
      <app-input
        class="form__group"
        v-model.trim="sessionEmail"
        label="Почта"
        required
        :errors="errors.user?.email"
      />
      <app-input
        class="form__group"
        v-model.trim="sessionPassword"
        label="Пароль"
        required
        :errors="errors.user?.password"
      />
      <div class="form__actions">
        <button class="btn btn--primary">
          Сохранить
        </button>
      </div>
    </form>
  </div>
</template>

<script>
import { mapFields } from '@/commons/helpers/mapFields'
import { mapState, mapActions, mapMutations } from "vuex"
import AppInput from '@/commons/components/Form/AppInput'

export default {
  components: {
    AppInput
  },
  props: {
    type: {
      type: String,
      required: true
    }
  },
  data() {
    return { }
  },
  computed: {
    ...mapState('error', ['errors']),
    ...mapState('session', ['session']),
    ...mapFields('session', 'session', 'SET_SESSION_PROPERTY', {
      sessionEmail: 'email',
      sessionPassword: 'password'
    }),
  },
  methods: {
    ...mapMutations("session", [
      "SET_SESSION",
    ]),
    ...mapActions('session', [
      "registerUser",
      "loginUser",
    ]),
    onSubmitForm() {
      const functionName = this.type == 'signin' ? 'loginUser' : 'registerUser'
      const params = {
        user: {
          email: this.session.email,
          password: this.session.password,
        }
      }
      this[functionName](params).then(_ => {
        window.location.href = '/'
      })
    }
  }
}
</script>
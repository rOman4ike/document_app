import { userStore } from '@/main/store/user.store'
import { sessionStore } from '@/commons/store/session.store'

export const baseStore = {
  modules: {
    user: { namespaced: true, ...userStore },
    session: { namespaced: true, ...sessionStore },
  },
}

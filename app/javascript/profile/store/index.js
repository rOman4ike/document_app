import { sessionStore } from "@/commons/store/session.store"
import { errorStore } from "@/commons/store/error.store"

export const baseStore = {
  modules: {
    session: { namespaced: true, ...sessionStore },
    error: { namespaced: true, ...errorStore },
  },
}

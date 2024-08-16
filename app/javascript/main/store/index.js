import { errorStore } from '@/commons/store/error.store'
import { configStore } from '@/commons/store/config.store'

import { changeOrderStore } from "@/main/store/changeOrder.store"
import { documentFileStore } from "@/main/store/documentFile.store"
import { documentStore } from "@/main/store/document.store"
import { initialOrderStore } from "@/main/store/initialOrder.store"
import { searchStore } from "@/main/store/search.store"
import { sessionStore } from '@/commons/store/session.store'
import { userStore } from '@/main/store/user.store'

import { activityAreaStore } from '@/directory/store/activityArea.store'
import { docTagStore } from '@/directory/store/docTag.store'

export const baseStore = {
  modules: {
    error: { namespaced: true, ...errorStore },
    config: { namespaced: true, ...configStore },
    changeOrder: { namespaced: true, ...changeOrderStore },
    document: { namespaced: true, ...documentStore },
    documentFile: { namespaced: true, ...documentFileStore },
    initialOrder: { namespaced: true, ...initialOrderStore },
    search: { namespaced: true, ...searchStore },
    session: { namespaced: true, ...sessionStore },
    user: { namespaced: true, ...userStore },
    activityArea: { namespaced: true, ...activityAreaStore },
    docTag: { namespaced: true, ...docTagStore },
  },
}

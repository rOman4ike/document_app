import { configStore } from '@/commons/store/config.store'
import { errorStore } from '@/commons/store/error.store'
import { docTagStore } from '@/directory/store/docTag.store'
import { activityAreaStore } from '@/directory/store/activityArea.store'

import { searchStore } from "@/main/store/search.store"

export const baseStore =  {
  modules: {
    config: { namespaced: true, ...configStore },
    error: { namespaced: true, ...errorStore },
    docTag: { namespaced: true, ...docTagStore },
    activityArea: { namespaced: true, ...activityAreaStore },
    search: { namespaced: true, ...searchStore }
  }
}

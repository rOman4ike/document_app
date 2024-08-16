import { routes } from '@/profile/routes/index'
import { baseStore } from '@/profile/store/index'
import { initVueConfig } from '@/commons/config'

document.addEventListener('DOMContentLoaded', () => {
  const Vue = initVueConfig(routes, baseStore)
  Vue.$mount('#profile-app')
})
import { routes } from '@/main/routes/index'
import { baseStore } from '@/main/store/index'
import { initVueConfig } from '@/commons/config'

document.addEventListener('DOMContentLoaded', () => {
  const Vue = initVueConfig(routes, baseStore)
  Vue.$mount('#main-app')
})
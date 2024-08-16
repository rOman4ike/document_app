import { initVueConfig } from '@/commons/config'
import { routes } from '@/directory/routes/index'
import { baseStore } from '@/directory/store/index'

document.addEventListener('DOMContentLoaded', () => {
  const Vue = initVueConfig(routes, baseStore)
  Vue.$mount('#directory-app')
})
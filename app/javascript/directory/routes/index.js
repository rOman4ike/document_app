const Dashboard = () => import('@/directory/views/Dashboard')
const DocTagIndex = () => import('@/directory/views/doc_tags/Index')
const ActivityAreaIndex = () => import('@/directory/views/activity_areas/Index')

export const routes = [
  {
    path: '/',
    name: 'dashboard',
    component: Dashboard,
    meta: {
      title: 'Справочники'
    }
  },
  {
    path: '/doc_tags',
    name: 'doc_tag_index',
    component: DocTagIndex,
    meta: {
      title: 'Ключевые слова'
    }
  },
  {
    path: '/activity_areas',
    name: 'activity_area_index',
    component: ActivityAreaIndex,
    meta: {
      title: 'Направления деятельности'
    }
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'not_found',
    redirect: () => {
      window.location.href = '404'
  }},
]

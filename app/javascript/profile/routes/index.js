const Dashboard = () => import('@/profile/views/Dashboard')

export const routes = [
  {
    path: '/',
    name: 'Dashboard',
    component: Dashboard,
    meta: {
      title: 'Документы'
    },
    alias: '/'
  },
  // Not Found
  {
    path: '/:pathMatch(.*)*',
    name: 'not_found',
    redirect: () => {
      window.location.href = '404'
    }
  },
]
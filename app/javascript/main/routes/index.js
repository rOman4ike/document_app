import Dashboard from '@/main/views/Dashboard'
import SignIn from '@/main/views/sessions/SignIn'
import SignUp from '@/main/views/sessions/SignUp'

export const routes = [
  { path: '/',
    component: Dashboard,
    name: 'dashboard'
  },
  {
    path: '/sessions/sign_in',
    component: SignIn,
    name: 'sessions_sign_in'
  },
  {
    path: '/sessions/sign_up',
    component: SignUp,
    name: 'sessions_sign_up'
  },
]

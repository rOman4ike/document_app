const DocumentIndex = () => import('@/main/views/documents/Index')
const DocumentNew = () => import('@/main/views/documents/New')
const DocumentShow = () => import('@/main/views/documents/Show')
const DocumentEdit = () => import('@/main/views/documents/Edit')

export const routes = [
  {
    path: '/documents',
    name: 'document_index',
    component: DocumentIndex,
    meta: {
      title: 'Документы'
    },
    alias: '/'
  },
  {
    path: '/documents/new',
    name: 'document_new',
    component: DocumentNew,
    meta: {
      title: 'Новый документ',
    },
  },
  {
    path: '/documents/:id(\\d+)',
    name: 'document_show',
    component: DocumentShow,
    meta: {
      title: 'Просмотр документа',
    },
  },
  {
    path: '/documents/:id(\\d+)/edit',
    name: 'document_edit',
    component: DocumentEdit,
    meta: {
      title: 'Редактирование документа',
    },
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
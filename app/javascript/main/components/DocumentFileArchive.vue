<template>
  <app-dropdown title="Архив файлов">
    <div class="table">
      <table class="table__inner">
        <thead class="table__thead">
          <tr>
            <th class="table__th">
              Наименование документов
            </th>
            <th class="table__th">
              Дата и время перемещения в архив
            </th>
            <th class="table__th">
              Каким файлом заменен
            </th>
            <th class="table__th">
              Действия
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(documentFile, index) in documentFiles"
            :key="documentFile.id"
          >
            <td class="table__td">
              {{ documentFile.file_file_name }}
            </td>
            <td class="table__td">
              {{ getDocumentFileDeletedAt(index) }}
            </td>
            <td class="table__td">
              {{ documentFile.replaced_file_file_name }}
            </td>
            <td class="table__td">
              <a
                class="icon icon--download"
                target="_blank"
                :href="documentFile.url"
                v-if="documentFile.url"
              >
              </a>
              <button
                class="icon icon--delete"
                @click="onDeleteDocumentFile(documentFile.id)"
              >
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </app-dropdown>
</template>

<script>
import { mapState, mapGetters, mapActions } from 'vuex'
import AppDropdown from '@/commons/components/AppDropdown'

export default {
  components: {
    AppDropdown
  },
  data() {
    return { }
  },
  computed: {
    ...mapState('documentFile', ['documentFiles']),
    ...mapGetters('documentFile', ['getDocumentFileDeletedAt'])
  },
  methods: {
    ...mapActions('documentFile', ['deleteDocumentFile']),
    ...mapActions('document', ['getDocument']),
    onDeleteDocumentFile(documentFileId) {
      this.deleteDocumentFile(documentFileId).then(_ => {
        const documentId = this.$route.params.id
        this.getDocument(documentId)
      })
    },
  }
}
</script>
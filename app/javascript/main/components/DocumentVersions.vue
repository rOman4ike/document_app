<template>
  <app-dropdown title="История изменения документа">
    <div class="table">
      <table class="table__inner">
        <thead class="table__thead">
          <tr>
            <th class="table__th">
              Кто
            </th>
            <th class="table__th">
              Когда
            </th>
            <th class="table__th">
              Действие
            </th>
            <th class="table__th table__th--full-width">
              Изменения
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(documentVersion, index) in documentVersions"
            :key="documentVersion.id"
          >
            <td class="table__td">
              {{ documentVersion.user }}
            </td>
            <td class="table__td">
              {{ getDocumentVersionsCreatedAt(index) }}
            </td>
            <td class="table__td">
              {{ documentVersion.action }}
            </td>
            <td class="table__td table__th--full-width">
              <div v-for="(value, key) in documentVersion.changeset">
                <template v-if="value[0] && value[1] && documentVersion.action == 'Изменение документа'">
                  <b>
                    {{ key }}:
                  </b>
                  <i>
                    {{ value[0] }} -> {{ value[1] }}
                  </i>
                </template>
                <template v-else>
                  <b>
                    {{ key }}:
                  </b>
                  <i>
                    {{ value[1]}}
                  </i>
                </template>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </app-dropdown>
</template>

<script>
import { mapState, mapGetters } from 'vuex'
import AppDropdown from '@/commons/components/AppDropdown'

export default {
  components: {
    AppDropdown
  },
  data() {
    return { }
  },
  computed: {
    ...mapState('document', ['documentVersions']),
    ...mapGetters('document', ['getDocumentVersionsCreatedAt'])
  }
}
</script>
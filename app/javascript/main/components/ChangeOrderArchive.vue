<template>
  <app-dropdown title="Архив приказов">
    <div class="table">
      <table class="table__inner">
        <thead class="table__thead">
          <tr>
            <th class="table__th">
              Номер документа
            </th>
            <th class="table__th">
              Дата и время перемещения в архив
            </th>
            <th class="table__th">
              Каким номером документа заменен
            </th>
            <th class="table__th">
              Действия
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(changeOrder, index) in changeOrders"
            :key="changeOrder.id"
          >
            <td class="table__td">
              {{ changeOrder.number }}
            </td>
            <td class="table__td">
              {{ getChangeOrderDeletedAt(index) }}
            </td>
            <td class="table__td">
              {{ changeOrder.replaced_number }}
            </td>
            <td class="table__td">
              <a
                class="icon icon--download"
                target="_blank"
                :href="changeOrder.url"
                v-if="changeOrder.url"
              >
              </a>
              <button
                class="icon icon--delete"
                @click="onDeleteChangeOrder(changeOrder.id)"
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
    ...mapState('changeOrder', ['changeOrders']),
    ...mapGetters('changeOrder', ['getChangeOrderDeletedAt'])
  },
  methods: {
    ...mapActions('changeOrder', ['deleteChangeOrder']),
    ...mapActions('document', ['getDocument']),
    onDeleteChangeOrder(changeOrderId) {
      this.deleteChangeOrder(changeOrderId).then(_ => {
        const documentId = this.$route.params.id
        this.getDocument(documentId)
      })
    },
  }
}
</script>
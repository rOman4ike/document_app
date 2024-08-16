<template>
  <div class="page">
    <header class="page-header">
      <h1 class="page-header__title">
        {{ document.title }}
      </h1>
      <div class="page-header__actions">
        <router-link
          class="btn btn--primary"
          :to="{ name: 'document_edit', params: { id: documentId } }"
        >
          Редактировать документ
        </router-link>
        <div>
          <a
            class="icon icon--download"
            target="_blank"
            :href="documentFile.url"
            v-if="documentFile.url"
          >
          </a>
          <button
            class="icon icon--copy"
            v-clipboard
          >
          </button>
          <button
            class="icon icon--delete"
            @click="onDeleteDocument"
          >
          </button>
        </div>
      </div>
    </header>

    <div v-if="!$helpers.isEmptyObject(initialOrder) || !$helpers.isEmptyObject(changeOrder)">
      <p v-if="!$helpers.isEmptyObject(initialOrder)">
        Введено приказом от {{ getInitialOrderInitialDate }} №{{ initialOrder.number }}
      </p>
      <p v-if="!$helpers.isEmptyObject(changeOrder)">
        Изменения внесены приказом от {{ getChangeOrderChangeDate }} №{{ changeOrder.number }}
      </p>
    </div>

    <dl class="description-list">
      <div class="description-list__item">
        <dt class="description-list__term">
          Категория:
        </dt>
        <dd class="description-list__definition">
          {{ document.kind }}
        </dd>
      </div>
      <div class="description-list__item">
        <dt class="description-list__term">
          Направление деятельности:
        </dt>
        <dd class="description-list__definition">
          <template
            v-for="activityArea in document.document_activity_areas"
          >
            {{ activityArea.title }},
          </template>
        </dd>
      </div>
      <div class="description-list__item">
        <dt class="description-list__term">
          Статус:
        </dt>
        <dd class="description-list__definition">
          {{ document.state }}
        </dd>
      </div>
    </dl>

    <ul class="list list--row">
      <li
        class="list__item"
        v-for="docTag in document.doc_tags"
      >
        <a
          class="link"
          @click="onAddTagToParams(docTag)"
        >
          <span class="icon icon--tag icon--sm"></span>
          {{ docTag.text }}
        </a>
      </li>
    </ul>

    <div
      class="card card--bg"
      id="initial-order"
      v-if="!$helpers.isEmptyObject(initialOrder)"
    >
      <div class="card__header">
        <div class="card__title">
          Приказ о введении в действие от {{ getInitialOrderInitialDate }} №{{ initialOrder.number }}
        </div>
        <div class="card__actions">
          <a
            class="icon icon--download"
            target="_blank"
            :href="initialOrder.url"
          >
          </a>
          <button
            class="icon icon--copy"
            v-clipboard="'#initial-order'"
          >
          </button>
        </div>
      </div>
    </div>

    <div
      class="card card--bg"
      id="change-order"
      v-if="!$helpers.isEmptyObject(changeOrder)"
    >
      <div class="card__header">
        <div class="card__title">
          Приказ о внесении изменений от {{ getChangeOrderChangeDate }} №{{ changeOrder.number }}
        </div>
        <div class="card__actions">
          <a
            class="icon icon--download"
            target="_blank"
            :href="changeOrder.url"
          >
          </a>
          <button
            class="icon icon--copy"
            v-clipboard="'#change-order'"
          >
          </button>
        </div>
      </div>
    </div>

    <document-versions
      v-if="documentVersions.length"
    />

    <document-file-archive
      v-if="documentFiles.length"
    />

    <change-order-archive
      v-if="changeOrders.length"
    />
  </div>
</template>

<script>
import { mapState, mapActions, mapGetters } from 'vuex'
import DocumentVersions from '@/main/components/DocumentVersions'
import DocumentFileArchive from '@/main/components/DocumentFileArchive'
import ChangeOrderArchive from '@/main/components/ChangeOrderArchive'

export default {
  components: {
    DocumentVersions,
    DocumentFileArchive,
    ChangeOrderArchive
  },
  data() {
    return {
      documentId: this.$route.params.id,
    }
  },
  computed: {
    ...mapState('document', [
      'document',
      'documentVersions'
    ]),
    ...mapState('initialOrder', ['initialOrder']),
    ...mapState('changeOrder', [
      'changeOrder',
      'changeOrders'
    ]),
    ...mapState('documentFile', [
      'documentFile',
      'documentFiles'
    ]),
    ...mapState('search', ['search']),
    ...mapGetters('search', ['createQuery']),
    ...mapGetters('initialOrder', ['getInitialOrderInitialDate']),
    ...mapGetters('changeOrder', ['getChangeOrderChangeDate'])
  },
  watch: {
    '$route'(to) {
      this.documentId = to.params.id
      this.getDocument(this.documentId)
    }
  },
  created() {
    this.getDocument(this.documentId)
  },
  destroyed() {
    this.$store.commit('document/SET_DOCUMENT', {})
    this.$store.commit('documentFile/SET_DOCUMENT_FILE', {})
    this.$store.commit('initialOrder/SET_INITIAL_ORDER', {})
    this.$store.commit('changeOrder/SET_CHANGE_ORDER', {})
  },
  methods: {
    ...mapActions('document', [
      'getDocument',
      'deleteDocument'
    ]),
    onDeleteDocument() {
      this.deleteDocument(this.documentId).then(_ => {
        this.$router.replace({ name: "document_index" })
      })
    },
    onAddTagToParams(docTag) {
      if (!this.search.doc_tags.some((searchDocTag) => searchDocTag.value == docTag.value)) {
        this.search.doc_tags.push(docTag)
      }
      this.$router
        .push({ name: 'document_index', query: this.createQuery })
        .catch(() => {})
    }
  },
}
</script>
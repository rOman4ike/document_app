<template>
  <div class="card">
    <div class="card__header">
      <router-link
        class="card__title link"
        :to="{ name: 'document_show', params: { id: document.id } }"
      >
        {{ document.title }}
      </router-link>

      <div class="card__actions">
        <a
          class="icon icon--download"
          target="_blank"
          :href="document.document_file.url"
          v-if="document.document_file.url"
        >
        </a>
        <button
          class="icon icon--copy"
          v-clipboard="documentPageUrl"
        >
        </button>
      </div>
    </div>

    <div v-if="document.initial_order || document.change_order">
      <p v-if="document.initial_order">
        Введено приказом от {{ formatDate(document.initial_order.initial_date) }} №{{ document.initial_order.number }}
      </p>
      <p v-if="document.change_order">
        Изменения внесены приказом от {{ formatDate(document.change_order.change_date) }} №{{ document.change_order.number }}
      </p>
    </div>

    <ul class="list list--row">
      <li
        class="list__item tag"
        v-for="activityArea in document.activity_areas"
      >
        {{ activityArea.title }}
      </li>
      <li
        class="list__item tag tag--danger"
        v-if="document.state == 'invalid'"
      >
        Утратил силу
      </li>
    </ul>

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
  </div>
</template>

<script>
import { mapState } from "vuex"

export default {
  props: {
    document: Object
  },
  data() {
    return {
      documentPageUrl: window.origin + '/#/' + 'documents/' + this.document.id
    }
  },
  computed: {
    ...mapState('search', ['search']),
  },
  methods: {
    formatDate(date) {
      return this.$dayjs(date)
        .format('DD.MM.YYYY')
    },
    onAddTagToParams(docTag) {
      if (this.search.doc_tags.some((searchDocTag) => searchDocTag.value == docTag.value)) return
      this.search.doc_tags.push(docTag)
      this.$emit('submit')
    }
  },
}
</script>
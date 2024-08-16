<template>
  <ul class="paginate">
    <li
      class="paginate__item paginate__previous"
      @click="onPreviousPage"
    >
      <
    </li>

    <li
      class="paginate__item"
      :class="{ 'paginate__item--active': current == page }"
      v-for="page in computedPages"
      @click="onChangePage(page)"
    >
      {{ page }}
    </li>

    <li
      class="paginate__item paginate__next"
      @click="onNextPage"
    >
      >
    </li>
  </ul>
</template>

<script>
export default {
  props: {
    pages: Number,
    current: Number,
    maxPages: Number
  },
  data() {
    return { }
  },
  computed: {
    computedPages() {
      if (this.maxPages > this.pages) return this.pages
      let firstPageNumber = this.current - Math.ceil(this.maxPages / 2) + 1
      let lastPageNumber = this.current + Math.floor(this.maxPages / 2)
      if (firstPageNumber <= 0) return this.maxPages
      if (lastPageNumber > this.pages) {
        firstPageNumber = this.pages - this.maxPages + 1
        lastPageNumber = this.pages
      }
      const pages = []
      for (let i = firstPageNumber; i <= lastPageNumber; i++) {
        pages.push(i)
      }
      return pages
    }
  },
  methods: {
    onPreviousPage() {
      if (this.current - 1 < 1) return
      this.$emit('change-page', this.current - 1)
    },
    onChangePage(page) {
      this.$emit('change-page', page)
    },
    onNextPage() {
      if (this.current + 1 > this.pages) return
      this.$emit('change-page', this.current + 1)
    }
  }
}
</script>
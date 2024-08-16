<template>
  <div class="page">
    <header class="page-header">
      <h1 class="page-header__title">
        Справочники
      </h1>
    </header>

    <ul class="list">
      <li class="list__item">
        <router-link
          class="link"
          :to="{ name: 'doc_tag_index' }"
        >
          Справочник ключевых слов
        </router-link>
      </li>
      <li class="list__item">
        <router-link
          class="link"
          :to="{ name: 'activity_area_index' }"
        >
          Справочник направлений деятельности
        </router-link>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return { }
  },
}
</script>
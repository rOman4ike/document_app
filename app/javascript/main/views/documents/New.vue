<template functional>
  <div class="page">
    <header class="page-header">
      <h1 class="page-header__title">
        Добавление нового документа
      </h1>
    </header>
    <component :is="props.components.DocumentForm"/>
  </div>
</template>

<script>
import DocumentForm from '@/main/components/DocumentForm.vue'

export default {
  props: {
    components: {
      type: Object,
      default() {
        return {
          DocumentForm
        }
      }
    }
  }
}
</script>

<style>

</style>
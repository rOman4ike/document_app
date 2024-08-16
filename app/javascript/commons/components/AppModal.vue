<template>
  <div class="modal">
    <div class="modal__outer">
      <div class="modal__inner">
        <slot></slot>
      </div>
    </div>
    <div
      class="modal__bg"
      @click="onCloseModal"
    ></div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      body: document.querySelector('body')
    }
  },
  created() {
    this.body.classList.add('js-disable-scroll')
  },
  destroyed() {
    this.body.classList.remove('js-disable-scroll')
  },
  methods: {
    onCloseModal() {
      this.$emit('close')
    }
  }
}
</script>
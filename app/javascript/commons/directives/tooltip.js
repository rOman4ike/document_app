export const tooltip = {
  inserted(el, binding, vnode) {
    const position = Object.keys(binding.modifiers)[0] || 'top'
    const value = binding.value

    el.dataset.tooltip = value
    el.classList.add('tooltip')
    el.classList.add(`tooltip--${position}`)
  }
}
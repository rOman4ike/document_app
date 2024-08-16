export const clipboard = {
  inserted(el, binding, vnode) {
    const value = binding.value
    let url = value

    if (!value) {
      url = window.location.href
    } else if (value[0] == '#') {
      url = window.location.href + value
    }

    el.addEventListener('click', function() {
      navigator.clipboard.writeText(url)
    })
  }
}
export const headerMenu = {
  initHeaderMenu() {
    const $headerMenuTrigger = document.querySelector('.js-header-menu')
    const $headerBlock = document.querySelector('.nav__outer')
    $headerMenuTrigger.addEventListener('click', function() {
      if ($headerBlock.classList.contains('js-visible-smooth')) {
        $headerBlock.classList.remove('js-visible-smooth')
        $headerBlock.classList.add('js-hidden-smooth')
        $headerMenuTrigger.classList.remove('icon--active')
      } else {
        $headerBlock.classList.remove('js-hidden-smooth')
        $headerBlock.classList.add('js-visible-smooth')
        $headerMenuTrigger.classList.add('icon--active')
      }
    })
  },
  removeJsClassesFromHeaderMenu() {
    document.querySelector('.nav__outer')
      .classList
      .remove('js-visible-smooth', 'js-hidden-smooth')
    document.querySelector('.js-header-menu')
      .classList
      .remove('icon--active')
  }
}

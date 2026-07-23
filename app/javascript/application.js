// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

/* Header Scroll */
document.addEventListener("turbo:load", function() {
  const header = document.querySelector(".home-header .header-main")
  const hero = document.querySelector(".hero")

  if (!header || !hero) {
    return
  }

  /* Check which navbar style the page should be using */
  function checkHeader() {
    if (window.scrollY > hero.offsetHeight - 100) {
      header.classList.add("is-sticky")
    } else {
      header.classList.remove("is-sticky")
    }
  }

  window.addEventListener("scroll", checkHeader)
  checkHeader()
})
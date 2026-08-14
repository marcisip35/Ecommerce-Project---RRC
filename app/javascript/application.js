import "@hotwired/turbo-rails"
import "controllers"

/* Header Scroll */
document.addEventListener("turbo:load", function() {
  const header = document.querySelector(".home-header .header-main")
  const hero = document.querySelector(".hero")

  if (!header || !hero) {
    return
  }

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

/* Header Menu */
document.addEventListener("click", function(event) {
  const menuButton = event.target.closest(".header-menu-button")

  if (!menuButton) {
    return
  }

  const header = document.querySelector(".site-header")

  if (!header) {
    return
  }

  header.classList.toggle("header-menu-open")

  if (header.classList.contains("header-menu-open")) {
    menuButton.setAttribute("aria-expanded", "true")
  } else {
    menuButton.setAttribute("aria-expanded", "false")
  }
})
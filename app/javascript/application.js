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
document.addEventListener("turbo:load", function() {
  const header = document.querySelector(".site-header")
  const menuButton = document.querySelector(".header-menu-button")

  if (!header || !menuButton) {
    return
  }

  menuButton.addEventListener("click", function() {
    header.classList.toggle("header-menu-open")

    if (header.classList.contains("header-menu-open")) {
      menuButton.setAttribute("aria-expanded", "true")
      menuButton.setAttribute("aria-label", "Close navigation")
    } else {
      menuButton.setAttribute("aria-expanded", "false")
      menuButton.setAttribute("aria-label", "Open navigation")
    }
  })
})
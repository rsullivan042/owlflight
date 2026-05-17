// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  const owlGuy = document.getElementById("owl-guy")
  const owlSound = document.getElementById("owl-sound")

  if (owlGuy && owlSound) {
    owlSound.volume = 0.5

    owlGuy.addEventListener("click", () => {
      owlSound.currentTime = 0
      owlSound.play()
    })
  }
})

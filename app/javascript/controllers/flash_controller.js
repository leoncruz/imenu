import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.slideOutAnimation();
    }, 3000);
  }

  slideOutAnimation() {
    this.element.classList.toggle('animate-slide-in');
    this.element.classList.toggle('animate-slide-out');

    this.element.addEventListener('animationend', () => {
      this.element.remove();
    })
  }
}

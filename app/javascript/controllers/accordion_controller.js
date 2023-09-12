import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="accordion"
export default class extends Controller {
  toggle() {
    this.element.querySelector('.items').classList.toggle('hidden');

    this.element.querySelector('#down-arrow').classList.toggle('hidden')
    this.element.querySelector('#up-arrow').classList.toggle('hidden')
  }
}

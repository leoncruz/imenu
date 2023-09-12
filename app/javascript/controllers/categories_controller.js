import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="categories"
export default class extends Controller {
  remove(event) {
    event.stopPropagation();

    this.element.parentElement.parentElement.parentElement.remove();
  }
}

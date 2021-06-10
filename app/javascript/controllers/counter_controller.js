import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ 'count', 'button' ];

  refresh(event) {
    event.preventDefault();
    fetch(`/park_categories/${this.countTarget.dataset.category}/votes`, { method: 'POST', headers: { accept: "application/json", 'X-CSRF-Token': csrfToken() } })
      .then(response => response.json())
      .then((data) => {
        console.log(this.buttonTarget);
        this.countTarget.innerText = data.counter;
        this.buttonTarget.classList.add('emoji-card-clicked')
      });
  }
}



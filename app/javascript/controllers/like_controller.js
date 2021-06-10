import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ 'link' ];

  connect(){
  }

  create() {
    fetch(`/parks/${this.linkTarget.dataset.park}/bookmarks`,  { method: 'POST', headers: { accept: "application/json", 'X-CSRF-Token': csrfToken() } })
      .then(response => response.json())
      .then((data) => {
        this.linkTarget.innerText = "";
        this.linkTarget.insertAdjacentHTML("beforeend", data.partial);
      });
  }

  delete() {
    console.log(this.linkTarget.querySelector('i').dataset.bookmark)
    fetch(`/bookmarks/${this.linkTarget.querySelector('i').dataset.bookmark}`,  { method: 'DELETE', headers: { accept: "application/json", 'X-CSRF-Token': csrfToken() } })
      .then(response => response.json())
      .then((data) => {
        this.linkTarget.innerText = "";
        this.linkTarget.insertAdjacentHTML("beforeend", data.partial);
      });
  }
  }


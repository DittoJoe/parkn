import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ 'link' ];

  connect(){
    console.log(this.linkTarget);
  }

  create() {
    fetch(`/parks/${this.linkTarget.dataset.park}/bookmarks`,  { method: 'POST', headers: { accept: "application/json", 'X-CSRF-Token': csrfToken() } })
      .then(response => response.json())
      .then((data) => {
        console.log(data.partial)
        this.linkTarget.innerText = "";
        this.linkTarget.insertAdjacentHTML("beforeend", data.partial);
      });
  }

  delete() {
    console.log(this.linkTarget.querySelector('a').dataset.bookmark)
    fetch(`/bookmarks/${this.linkTarget.querySelector('a').dataset.bookmark}`,  { method: 'DELETE', headers: { accept: "application/json", 'X-CSRF-Token': csrfToken() } })
      .then(response => response.json())
      .then((data) => {
        console.log(data.partial)
        this.linkTarget.innerText = "";
        this.linkTarget.insertAdjacentHTML("beforeend", data.partial);
      });
  }
  }


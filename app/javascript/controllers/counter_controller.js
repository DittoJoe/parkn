// import { Controller } from "stimulus";

// export default class extends Controller {
//   static targets = [ 'count' ];

//   refresh(event) {
//     console.log(this.countTarget.dataset.category);
//   }
// }

import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ 'count' ];

  refresh(event) {
    event.preventDefault();
    fetch(`/park_categories/${this.countTarget.dataset.category}/votes`, { method: 'POST', headers: { accept: "application/json", 'X-CSRF-Token': csrfToken() } })
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        this.countTarget.innerText = data.counter;
      });
  }
}

// import { Controller } from "stimulus";

// export default class extends Controller {
//   static targets = [ 'count' ];

//   refresh() {
//     fetch('/restaurants', { headers: { accept: 'application/json' } })
//       .then(response => response.json())
//       .then((data) => {
//         this.countTarget.innerText = data.restaurants.length;
//       });
//   }
// }

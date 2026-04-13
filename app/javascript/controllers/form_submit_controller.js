import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["frame"];
  static values = {
    url: String,
    frameId: String
  };

  handleSubmit() {
    const turboFrame = document.getElementById(this.frameIdValue);
    turboFrame.src = this.urlValue;
  }

  debounce(callback, delay) {
    let timer
    return function () {
      clearTimeout(timer)
      timer = setTimeout(() => {
        callback();
      }, delay)
    }
  }
}

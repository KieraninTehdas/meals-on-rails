import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["frame"];
  static values = {
    url: String,
    frameId: String
  };

  handleSubmit(event) {
    // TODO: DEBOUNCE THIS!
    const turboFrame = document.getElementById(this.frameIdValue);
    const searchValue = event.target.value;
    const selectedRecipeInput = document.getElementById("recipe-ids-input");
    const selectedIds = selectedRecipeInput ? selectedRecipeInput.value : "";
    
    const params = new URLSearchParams();
    params.append("q", searchValue);
    if (selectedIds) {
      params.append("selected_ids", selectedIds);
    }
    
    turboFrame.src = `${this.urlValue}?${params.toString()}`;
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

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["trigger", "dependent"];

  connect() {
    this.updateDependentState();
  }

  updateDependentState() {
    const isTriggered = this.triggerTarget.value.trim() !== "";
    this.dependentTarget.disabled = !isTriggered;

    if (!isTriggered) {
      this.dependentTarget.value = this.dependentTarget.defaultValue;
    }
  }
}

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["selectedList", "recipeInput"];

  addRecipe(event) {
    event.preventDefault();
    const button = event.currentTarget;
    const recipeId = button.dataset.recipeId;
    const recipeName = button.dataset.recipeName;
    const recipeLabels = button.dataset.recipeLabels;

    // Check if already selected
    if (this.isRecipeSelected(recipeId)) return;

    // Add to selected list
    const selectedList = this.selectedListTarget;
    const recipeDiv = document.createElement("div");
    recipeDiv.className = "flex items-center justify-between p-2 bg-gray-100 rounded mb-2";
    recipeDiv.dataset.recipeId = recipeId;
    recipeDiv.innerHTML = `
      <div class="flex items-center gap-2">
        <span>${recipeName}</span>
        ${recipeLabels ? `<span class="text-sm text-gray-600">${recipeLabels}</span>` : ""}
      </div>
      <button type="button" data-action="click->recipe-selector#removeRecipe" class="text-red-600 hover:text-red-800 font-medium">
        Remove
      </button>
    `;

    // Remove placeholder text if present
    const placeholder = selectedList.querySelector(".text-gray-500");
    if (placeholder) placeholder.remove();

    selectedList.appendChild(recipeDiv);

    // Update hidden input
    this.updateRecipeIds();

    // Refresh search results
    this.refreshSearchResults();
  }

  removeRecipe(event) {
    event.preventDefault();
    const button = event.currentTarget;
    const recipeDiv = button.closest("[data-recipe-id]");
    const recipeId = recipeDiv.dataset.recipeId;

    recipeDiv.remove();

    // Check if selected list is now empty
    if (this.selectedListTarget.querySelectorAll("[data-recipe-id]").length === 0) {
      this.selectedListTarget.innerHTML = '<p class="text-gray-500">No recipes selected</p>';
    }

    // Update hidden input
    this.updateRecipeIds();

    // Refresh search results
    this.refreshSearchResults();
  }

  isRecipeSelected(recipeId) {
    return this.selectedListTarget.querySelector(`[data-recipe-id="${recipeId}"]`) !== null;
  }

  updateRecipeIds() {
    const selectedRecipes = Array.from(
      this.selectedListTarget.querySelectorAll("[data-recipe-id]")
    ).map((el) => el.dataset.recipeId);

    this.recipeInputTarget.value = selectedRecipes.join(",");
  }

  refreshSearchResults() {
    const searchInput = document.getElementById("recipe-search-input");
    if (searchInput && searchInput.value.trim()) {
      // Trigger the form-submit controller to refresh
      searchInput.dispatchEvent(new Event("input", { bubbles: true }));
    }
  }
}

class RecipeSearchesController < ApplicationController
  def create
    @matching_recipes = Recipe.joins(:labels).where(labels: params[:label_ids])
    render :result
  end
end

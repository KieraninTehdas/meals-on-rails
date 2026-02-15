class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = Recipe.all
  end

  def show; end

  def new
    @recipe = Recipe.new
  end

  def edit; end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to action: "index"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to action: "index"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_url
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    cleaned_params = params.require(:recipe).permit(:name, :recipe_book_id, :page_number, :ingredients, label_ids: [])

    cleaned_params[:ingredients] = cleaned_params[:ingredients].strip if cleaned_params[:ingredients]

    cleaned_params
  end
end

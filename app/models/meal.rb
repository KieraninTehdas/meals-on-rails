class Meal < ApplicationRecord
  self.table_name = "meals"

  belongs_to :recipe
  belongs_to :meal_plan

  def recipe_book_name
    recipe.recipe_book_name
  end

  def name
    recipe.name
  end
end

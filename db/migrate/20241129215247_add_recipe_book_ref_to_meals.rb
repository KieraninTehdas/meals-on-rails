class AddRecipeBookRefToMeals < ActiveRecord::Migration[7.2]
  def change
    add_reference :meals, :recipe_book, null: true, foreign_key: true
  end
end

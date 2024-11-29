class AddRecipeBookRefToMeals < ActiveRecord::Migration[7.2]
  def change
    add_reference :meals, :meals, null: false, foreign_key: true
  end
end

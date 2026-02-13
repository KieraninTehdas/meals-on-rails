class RenameMealsToRecipes < ActiveRecord::Migration[7.2]
  def change
    rename_table :meals, :recipes
  end
end

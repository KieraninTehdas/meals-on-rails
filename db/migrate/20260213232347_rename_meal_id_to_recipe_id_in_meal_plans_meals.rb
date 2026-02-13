class RenameMealIdToRecipeIdInMealPlansMeals < ActiveRecord::Migration[7.2]
  def change
    rename_column :meal_plans_meals, :meal_id, :recipe_id
  end
end

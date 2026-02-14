class RenameMealPlanMealsToMeals < ActiveRecord::Migration[7.2]
  def change
    rename_table :meal_plans_meals, :meals
  end
end

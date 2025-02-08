class MealPlanMeal < ApplicationRecord
  self.table_name = "meal_plans_meals"

  belongs_to :meal
  belongs_to :meal_plan

  def recipe_book_name
    meal.recipe_book_name
  end

  def name
    meal.name
  end
end

class MealPlanMeal < ApplicationRecord
  self.table_name = "meal_plans_meals"

  belongs_to :meal
  belongs_to :meal_plan
end

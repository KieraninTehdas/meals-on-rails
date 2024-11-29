module MealPlansHelper
  def plan_meal_url(plan_meal_id)
    # TODO: hostname should be set dynamically
    Rails.logger.info(plan_meal_id)
    "http://localhost:3000/meal-plan-meals/#{plan_meal_id}"
  end
end

class MealPlanMealsController < ApplicationController
  def eat
    plan_meal = MealPlanMeal.find(params[:id])

    plan_meal.update!(eaten: true)

    respond_to do |format|
      format.json
      format.js
    end
  end

  def revert_eating
    plan_meal = MealPlanMeal.find(params[:id])

    plan_meal.update!(eaten: false)

    respond_to do |format|
      format.json
      format.js
    end
  end
end

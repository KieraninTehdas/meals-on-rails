class MealsController < ApplicationController
  def update_eaten_status
    meal = Meal.find(params[:id])

    meal.update!(eaten: params[:updated_value])

    respond_to do |format|
      format.json
      format.js
    end
  end
end

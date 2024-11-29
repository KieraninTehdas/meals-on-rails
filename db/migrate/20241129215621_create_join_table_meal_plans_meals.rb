class CreateJoinTableMealPlansMeals < ActiveRecord::Migration[7.2]
  def change
    create_join_table :meal_plans, :meals do |t|
      # t.index [:meal_plan_id, :meal_id]
      # t.index [:meal_id, :meal_plan_id]
    end
  end
end

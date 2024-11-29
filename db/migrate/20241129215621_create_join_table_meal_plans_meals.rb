class CreateJoinTableMealPlansMeals < ActiveRecord::Migration[7.2]
  def change
    create_table :meal_plans_meals do |t|
      t.integer :meal_plan_id
      t.integer :meal_id
      t.boolean :eaten
      t.timestamps
    end
  end
end

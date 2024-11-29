class CreateMeals < ActiveRecord::Migration[7.2]
  def change
    create_table :meals do |t|
      t.string :name
      t.integer :page_number
      t.text :ingredients

      t.timestamps
    end
  end
end

class CreateRecipeBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :recipe_books do |t|
      t.string :name

      t.timestamps
    end
  end
end

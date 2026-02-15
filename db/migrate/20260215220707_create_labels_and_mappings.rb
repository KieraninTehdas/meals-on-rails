class CreateLabelsAndMappings < ActiveRecord::Migration[7.2]
  def change
    create_table :labels do |t|
      t.string :name

      t.timestamps
    end

    create_table :labels_recipes, id: false do |t|
      t.belongs_to :label
      t.belongs_to :recipe
    end
  end
end

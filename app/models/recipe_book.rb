class RecipeBook < ApplicationRecord
  before_destroy { |book| Recipe.where(recipe_book: book).update_all(page_number: nil) }

  has_many :recipes, dependent: :nullify

  validates :name, presence: true
end

class Recipe < ApplicationRecord
  belongs_to :recipe_book, optional: true

  has_many :meals, dependent: :delete_all
  has_many :meal_plans, through: :meals

  has_and_belongs_to_many :labels

  validates :name, presence: true
  validates :page_number, numericality: { only_integer: true, allow_nil: true }
  validates :recipe_book, presence: true, if: -> { page_number.present? }

  def recipe_book_name
    recipe_book&.name
  end
end

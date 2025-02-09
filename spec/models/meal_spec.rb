require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe "#recipe_book_name" do
    subject { meal.recipe_book_name }

    context "when meal is not associated with a recipe book" do
      let(:meal) { Meal.create(name: "Dinner") }

      it { is_expected.to be nil }
    end

    context "when meal is associated with a recipe book" do
      let(:recipe_book) { RecipeBook.create(name: "Nigella Ramsay") }
      let(:meal) { Meal.create(name: "Dinner", recipe_book: recipe_book) }

      it { is_expected.to eq "Nigella Ramsay" }
    end
  end
end

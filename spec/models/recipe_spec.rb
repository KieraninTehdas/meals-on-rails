require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe "#recipe_book_name" do
    subject { recipe.recipe_book_name }

    context "when recipe is not associated with a recipe book" do
      let(:recipe) { Recipe.create(name: "Dinner") }

      it { is_expected.to be nil }
    end

    context "when recipe is associated with a recipe book" do
      let(:recipe_book) { RecipeBook.create(name: "Nigella Ramsay") }
      let(:recipe) { Recipe.create(name: "Dinner", recipe_book: recipe_book) }

      it { is_expected.to eq "Nigella Ramsay" }
    end
  end

  describe "labels" do
    context "when adding a label to a recipe" do
      it "correctly associates the label to the recipe" do
        recipe = Recipe.create!(name: "Salad")
        label = Label.create!(name: "Vegetarian")

        recipe.labels << label

        expect(recipe.labels.size).to eq 1
      end
    end
  end
end

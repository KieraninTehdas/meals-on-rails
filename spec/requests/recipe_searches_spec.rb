require "rails_helper"

RSpec.describe "Recipe Searching", type: :request do
  let(:veggie_label) { Label.create!(name: "Veggie") }
  let(:quick_label) { Label.create!(name: "Quick") }

  let!(:veggie_recipe) { Recipe.create!(name: "Lettuce", labels: [ veggie_label ]) }
  let!(:quick_veggie_recipe) { Recipe.create!(name: "Bread", labels: [ veggie_label, quick_label ]) }

  it "can search by label" do
    post "/recipe_searches", params: { label_ids: [ veggie_label.id ] }

    expect(response).to be_successful
    expect(response.body).to include(veggie_recipe.name, quick_veggie_recipe.name)

    post "/recipe_searches", params: { label_ids: [ quick_label.id ] }

    expect(response).to be_successful
    expect(response.body).to include(quick_veggie_recipe.name)
    expect(response.body).not_to include(veggie_recipe.name)
  end
end

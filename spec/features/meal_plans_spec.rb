require 'rails_helper'

RSpec.feature "MealPlans", type: :feature do
  scenario "User creates a meal plan" do
    5.times { Recipe.create!(name: Faker::Food.unique.dish) }

    visit "/"

    expect(page).to have_text("This Week We Shall Mostly Be Eating")
    expect(page).to have_text("Nothing")

    click_on "New plan"

    fill_in "Start date", with: Date.today
    fill_in "End date", with: 3.days.from_now.to_date

    plan_recipes = Recipe.pluck(:name).sample(3)

    plan_recipes.each { |recipe_name| check(recipe_name) }

    click_button "New meal plan"

    expect(page).to have_text("This Week We Shall Mostly Be Eating")
    plan_recipes.each { |recipe_name| expect(page).to have_text(recipe_name) }
  end
end

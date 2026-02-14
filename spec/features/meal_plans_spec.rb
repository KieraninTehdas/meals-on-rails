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

  scenario "User edits a meal plan" do
    plan_recipe_names = %w[fish chips mushy peas pizza]
    (plan_recipe_names + %w[pasta]).each { |recipe_name| Recipe.create!(name: recipe_name) }


    meal_plan = MealPlan.create!(start_date: Date.today, end_date: 5.days.from_now.to_date, recipes: Recipe.where(name: plan_recipe_names))

    visit "/"

    expect(page).to have_text("This Week We Shall Mostly Be Eating")
    expect(page).to have_text("#{meal_plan.start_date.to_fs(:long)} --> #{meal_plan.end_date.to_fs(:long)}")
    plan_recipe_names.each { |name| expect(page).to have_text(name) }

    click_on "Edit"

    fill_in "End date", with: 3.days.from_now.to_date

    uncheck "mush"
    uncheck "peas"
    uncheck "pizza"
    check "pasta"

    click_button "Save"

    expect(page).to have_text("This Week We Shall Mostly Be Eating")
    expect(page).to have_text("#{meal_plan.start_date.to_fs(:long)} --> #{3.days.from_now.to_date.to_fs(:long)}")
    %w[fish chips pasta].each { |name| expect(page).to have_text(name) }
    %w[mush peas pizza].each { |name| expect(page).not_to have_text(name) }
  end
end

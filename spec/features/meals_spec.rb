require 'rails_helper'

RSpec.feature "Meals", type: :feature, js: true do
  scenario "User creates a new meal with a recipe book" do
    RecipeBook.create(name: "Book 1")

    visit "/meals"

    click_on "New meal"

    expect(page).to have_text "New Meal"

    # Page number is disabled if no recipe book is selected
    find_field("Page number", disabled: true)
    fill_in("Name", with: "Egg and Chips")
    select("Book 1")
    fill_in("Page number", with: "27")
    fill_in("Ingredients", with: "egg, chips, ketchup")
    click_button("Save")

    expect(page).to have_current_path(meals_path)
    expect(page).to have_text "Egg and Chips"
  end

  scenario "User creates a new meal without a recipe book" do
    visit "/meals"

    click_on "New meal"

    expect(page).to have_text "New Meal"

    # Page number is disabled if no recipe book is selected
    find_field("Page number", disabled: true)
    fill_in("Name", with: "Egg and Chips")
    fill_in("Ingredients", with: "egg, chips, ketchup")
    click_button("Save")

    expect(page).to have_current_path(meals_path)
    expect(page).to have_text "Egg and Chips"
  end

  scenario "User edits a meal" do
    Meal.create(name: "Salmon", ingredients: "Salmon I guess?")
    RecipeBook.create(name: "Book 1")

    visit "/meals"

    click_on "Salmon"

    expect(page).to have_text "Salmon"
    expect(page).to have_text "Ingredients"
    expect(page).not_to have_text "Recipe Book:"

    click_on "Edit"

    select "Book 1"

    click_button "Save"

    expect(page).to have_current_path(meals_path)
    click_on "Salmon"

    expect(page).to have_text("Recipe Book: Book 1")
  end
end

namespace :db do
  task populate: [ :environment ] do
    require "faker"

    5.times do
      RecipeBook.create!(name: Faker::Books::Lovecraft.tome)
    end

    10.times do
      recipe = Recipe.new(name: Faker::Food.dish)

      if [ true, false ].sample
        recipe.recipe_book = RecipeBook.all.sample
        recipe.page_number = rand(300)
      end

      recipe.ingredients = Array.new(8) { Faker::Food.ingredient }.join("\n")

      recipe.save!
    end
  end
end

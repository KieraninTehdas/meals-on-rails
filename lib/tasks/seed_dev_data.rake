namespace :db do
  task populate: [ :environment ] do
    require "faker"

    5.times do
      RecipeBook.create!(name: Faker::Books::Lovecraft.tome)
    end

    10.times do
      meal = Meal.new(name: Faker::Food.dish)

      if [ true, false ].sample
        meal.recipe_book = RecipeBook.all.sample
        meal.page_number = rand(300)
      end

      meal.ingredients = Array.new(8) { Faker::Food.ingredient }.join("\n")

      meal.save!
    end
  end
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root to: "meal_plans#index"

  resources :meal_plans, path: "/meal-plans" do
    collection do
      get "past", to: "meal_plans#past_meal_plans"
    end
    member do
      get "shopping-list", to: "meal_plans#generate_shopping_list"
    end
  end

  resources :recipe_books, path: "/recipe-books" do
    collection do
      get "search", to: "recipe_books#search"
    end
  end
  resources :recipes

  resources :meals do
    member do
      put "update_eaten_status"
    end
  end
end

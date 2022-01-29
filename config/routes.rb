Rails.application.routes.draw do
  resources :games do
    resources :critics, only: %w[create destroy], module: :games
    resources :platforms, only: %w[create destroy]
    resources :genres, only: %w[create destroy]
    resources :involved_companies, only: %w[create destroy]
  end
  resources :companies do
    resources :critics, only: %w[create destroy], module: :companies
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "games#index"
end

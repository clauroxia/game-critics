Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: :callbacks }

  resources :games do
    resources :critics, only: %w[index create destroy update], module: :games
    resources :platforms, only: %w[create destroy]
    resources :genres, only: %w[create destroy]
  end
  resources :companies do
    resources :critics, only: %w[index create destroy update], module: :companies
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  delete "/games/:game_id/companies/:company_id", to: "involved_companies#destroy", as: :game_company
  post "/games/:game_id/companies", to: "involved_companies#create", as: :game_companies

  # Defines the root path route ("/")
  root "games#index"
end

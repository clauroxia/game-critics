Rails.application.routes.draw do
  resources :involved_companies
  resources :genres
  resources :platforms
  resources :games
  resources :companies
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

#defines routes for the methods in the application
Rails.application.routes.draw do

  resources :courses
  
  #root is the home page of the application
  root 'home#index'
  
  resources :users, only: [:create, :show]
  
  #routes for the signup, login, and logout 
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"
end

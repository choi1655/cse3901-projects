Rails.application.routes.draw do

  get '/home', to: "home#index"
  post '/home', to: "home#index"
  resources :recommendation_forms
  resources :student_applications
  
  #root is the home page of the application
  root 'sessions#index'

  get 'instructor_view', to: 'instructor_view#index'
  get 'student_application' ,to: 'student_application#index'
  post 'student_application' ,to: 'student_application#create'
  
  resources :users, only: [:create, :show, :change_password]
  
  #routes for the signup, login, and logout 
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/signupinstr", to: "users#newinstr"
  post "/signupinstr", to: "users#create_instr"
  get "/login", to: "sessions#new"
  get "/newpassword", to: "users#newpassword"
  post "/newpassword", to: "users#change_password"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"
  
  get 'admin/applications'
  get 'admin/users'
  get 'admin/classes'
  get 'admin/instructor_selection'
  post 'admin/select_instructor'
  post 'admin/reset_password'
  get 'admin/assign_student', to: "admin#assign_student"
  get 'admin/rec', to: "admin#rec_display"
  post 'admin/assign_student', to: "admin#assign"
  post 'admin/approve_instructor'
  post 'admin/requires_graders'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

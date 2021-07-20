Rails.application.routes.draw do

  resources :rooms
  resources :users

  resource :confirmation, :only => [:show]

  resource :user_sessions, :only => [:create, :new, :destroy]
  
  root :to => "home#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

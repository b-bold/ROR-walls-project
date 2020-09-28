Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only:[:new, :create]
  resource :session, only:[:new, :create, :destroy]
  resources :walls, only:[:index, :create, :new, :show, :edit, :update]
  resources :wall_rental_requests, only:[:new, :create] do
    member do
        post :approve
        post :deny
    end 
  end 
  
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :walls, only: [:index, :create, :new, :show, :edit, :update]
  resources :wall_rental_requests, only: [:index, :new, :create, :show, :approve, :deny]
end

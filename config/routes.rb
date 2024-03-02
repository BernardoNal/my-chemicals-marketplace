Rails.application.routes.draw do
  root to: "products#index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get "up" => "rails/health#show", as: :rails_health_check

  resources :products do
    get "myproducts", on: :collection
    resources :purchases, only: [:create]
    resources :reviews, only: %i[new create]
  end

  resources :reviews, only: :destroy
  get "mypurchases" => 'purchases#mypurchases'
end

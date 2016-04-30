Rails.application.routes.draw do
  devise_for :users

  resources :users, param: :name do
    resources :entries
  end

  root to: 'home#index'
end

Rails.application.routes.draw do
  devise_for :users

  resources :users, param: :name do
    resources :entries, param: :slug
  end

  root to: 'home#index'
end

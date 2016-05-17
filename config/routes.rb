Rails.application.routes.draw do
  devise_for :users

  resources :categories, only: :show
  resources :upload, controller: :assets, as: :assets, only: :create

  resources :users, param: :name do
    resources :entries, only: :new
    resources :entries, except: [:new, :show], param: :slug, constraints: { format: false } do
      collection do
        get '*slug/edit', action: :edit
        get '*slug', action: :show
        put '*slug', action: :update
        patch '*slug', action: :update
        delete '*slug', action: :destroy
      end
    end
  end

  namespace :admin do
    resource :dashboard, only: [:show]

    resources :users
    resources :entries
    resources :categories, only: [:index, :create]
    resources :assets
    resources :advertisements
    resource :blog, controller: :blog, only: [:show, :edit, :update]

    get :profile, controller: :users

    root to: 'dashboard#show'
  end

  # for DoRuby
  get ':user_name/:date/*slug', to: 'entries#doruby', constraints: { date: /\d{8}/, slug: /[^\/]*/, format: false }
  get ':user_name/files/*filename', to: 'entries#doruby_file', constraints: { filename: /[^\/]*/, format: false }

  root to: 'home#index'
end

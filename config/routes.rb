Rails.application.routes.draw do
  devise_for :users

  resources :categories, only: :show
  resources :tags, only: :show
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

  resource :profile, controller: :profile, only: [:show, :edit, :update] do
    collection do
      get :entries
    end
  end

  resources :pages, only: [:show]

  namespace :admin do
    resource :dashboard, only: [:show]

    resources :users
    resources :entries
    resources :categories, only: [:index, :create]
    resources :assets
    resources :advertisements do
      member do
        post :move_lower
        post :move_higher
        post :move_to_bottom
        post :move_to_top
      end
    end
    resources :navigations do
      member do
        post :move_lower
        post :move_higher
        post :move_to_bottom
        post :move_to_top
      end
    end
    resources :recommends do
      member do
        post :move_lower
        post :move_higher
        post :move_to_bottom
        post :move_to_top
      end
    end
    resources :pages
    resources :trackers
    resource :blog, controller: :blog, only: [:show, :edit, :update]

    get :profile, controller: :users

    root to: 'dashboard#show'
  end

  get '/feed', to: 'home#feed', as: :feed, defaults: { format: 'atom' }

  # for DoRuby
  get ':user_name/:date/*slug', to: 'entries#doruby', constraints: { date: /\d{8}/, slug: /[^\/]*/, format: false }
  get ':user_name/files/*filename', to: 'entries#doruby_file', constraints: { filename: /[^\/]*/, format: false }
  get '/blog/feed_all' => redirect('/feed')

  root to: 'home#index'
end

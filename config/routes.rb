Rails.application.routes.draw do
  devise_for :users

  resources :users, param: :name do
    resources :entries, param: :slug, except: :show do
      collection do
        get '*slug', action: :show, constraints: { format: false }
      end
    end
  end

  # for DoRuby
  get ':user_name/:date/*slug', to: 'entries#doruby', constraints: { date: /\d{8}/, slug: /[^\/]*/, format: false }

  root to: 'home#index'
end

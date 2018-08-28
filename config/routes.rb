require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  root 'home#index'
  get  '/articles/:id', to: 'articles#show', as: 'article'

  devise_for(:users,
    only: %i[sessions registrations],
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  )

  namespace :admin do
    root 'home#index'

    resources :articles, only: %i[index new create edit update show] do#destroy
      collection do
        get 'trash'
        put 'publish/:id', to: 'articles#publish'
        get 'convert_html'
        delete 'delete/:id', to: 'articles#delete'
      end
    end

    resources :labels, only: %i[index create update destroy]

    post 'markdown/convert_html'


    authenticate :user do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  unless Rails.env.development?
    match '*path', to: 'error#no_match', via: :all, constraints: lambda { |request|
      return true;
    }
  end
end
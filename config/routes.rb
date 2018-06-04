Rails.application.routes.draw do

  root 'home#index'
  get '/:category', to: 'articles#search', as: '/', constraints: lambda { |request|
    Category.en_names.include?(request[:category])
  }

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

    resources :articles, only: %i[index new create edit update destroy show] do
      collection do
        get  'trash'
        post 'update_status'
        get  'convert_html'
      end
    end

    resources :categories, only: %i[index create update destroy] do
      collection do
        post 'move_up'
        post 'move_down'
      end
    end
    resources :notices, only: %i[index create destroy]

    post 'markdown/convert_html'

    require 'sidekiq/web'
    require 'sidekiq/cron/web'

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
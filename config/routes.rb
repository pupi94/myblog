# frozen_string_literal: true

require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  root "home#index"

  devise_for(:users,
             only: %i[sessions registrations],
             controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations"
             })

  resources :articles, only: %i[show index]

  namespace :admin do
    root "home#index"

    resources :articles do
      member do
        patch :publish
        patch :unpublish
      end
    end

    resources :labels, only: %i[index create update destroy]

    post "markdown/convert_html"

    authenticate :user do
      mount Sidekiq::Web => "/sidekiq"
    end
  end

  unless Rails.env.development?
    match "*path", to: "error#no_match", via: :all, constraints: lambda { |_request|
      return true
    }
  end
end

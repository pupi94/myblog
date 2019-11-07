# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  devise_for :users, only: %i[sessions], controllers: { sessions: "users/sessions" }

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
  end

  match "*path", to: "error#no_match", via: :all
end

# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  devise_for :users, only: %i[sessions], controllers: { sessions: "users/sessions" }

  resources :articles, only: %i[show index]

  namespace :admin do
    root "home#index"
    get '/*path' => 'home#index'
  end

  namespace :api do
    namespace :admin do
      resource :user, only: [:show]
    end
  end
end

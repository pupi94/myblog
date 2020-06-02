# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  devise_for :users, only: %i[sessions], controllers: { sessions: "users/sessions" }

  namespace :admin do
    root "home#index"
    get "/*path" => "home#index"
  end

  namespace :api, defaults: { format: :json } do
    namespace :admin do
      resource :user, only: [:show]
    end

    match "*path", to: "base#render_not_found", via: :all
  end
end

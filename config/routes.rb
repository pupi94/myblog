Rails.application.routes.draw do
  root 'home#index'

  get  'login', to: 'users#login'
  post 'login', to: 'users#do_login'
  get  'logout', to: 'users#logout'

  get  '/articles/:id', to: 'articles#show', as: 'article'
  get  '/home/paging_search'

  namespace :admin do
    root 'home#index'

    resources :articles, only:[:index, :new, :create, :edit, :update, :destroy] do
      collection do
        get  'trash_list'
        post 'update_status'
        get  'convert_html'
      end
    end

    resources :categories, only: [:index, :create]

    post 'markdown/convert_html'
  end

  post 'attachment/upload'
  get  'attachment/download'

  unless Rails.env.development?
    match '*path', to: 'error#no_resources', via: :all, constraints: lambda { |request|
      return true;
    }
  end
end

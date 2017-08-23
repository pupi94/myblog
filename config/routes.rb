Rails.application.routes.draw do

  root 'home#index'

  get  'home/index'
  # admin
  get  'management/index'

  # categories
  get  'categories/index'
  post 'categories/create'

  # users
  get  'users/login'
  post 'users/do_login'
  get  'users/do_login', to: 'users#login'
  get  'users/logout'

  #article
  get  'articles/new'
  post 'articles/create'
  get  'articles/index'

  #tag
  post 'tags/create'

  post 'attachment/update'
  get  'attachment/download'
end

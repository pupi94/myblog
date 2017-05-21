Rails.application.routes.draw do

  root 'home#index'

  # admin
  get  'content_manage/index'

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
  get  'articles/preview'

  #tag
  post 'tags/create'
end

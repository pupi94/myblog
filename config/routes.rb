Rails.application.routes.draw do

  root 'home#index'

  # admin
  get  'admin/index'

  # categories
  get  'categories/index'

  # users
  get  'users/login'
  post 'users/do_login'
  get  'users/do_login', to: 'users#login'
  get  'users/logout'
end

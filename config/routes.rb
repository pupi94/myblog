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
  # 加上这个url后，在登录失败后刷新登录页面就不会报错了
  get  'users/do_login', to: 'users#login'

  get  'users/logout'

  #article
  get  'articles/new'
  post 'articles/create'
  get  'articles/edit'
  get  'articles/index'
  get  'articles/trash_list'
  post 'articles/update'
  post 'articles/update_status'
  get  'articles/:id', to: 'articles#show'

  post 'attachment/update'
  get  'attachment/download'
end

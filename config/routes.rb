Rails.application.routes.draw do

	root 'articles#new'
	
	get  'home/index'

	get  'articles/index'
	get  'articles/new'
	post 'articles/create'
	get  'articles/show'

	get  'users/login'
	post 'users/do_login'

	get  'admin/index'
end

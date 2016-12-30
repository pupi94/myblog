Rails.application.routes.draw do

	root 'articles#new'
	
	get  'home/index'

	get  'articles/index'
	get  'articles/new'
	post 'articles/create'
	get  'articles/show'
end

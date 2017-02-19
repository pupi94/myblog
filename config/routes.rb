Rails.application.routes.draw do
 
 	root  'home#index'

 	# admin
 	get  'admin/index'

 	# categories
 	get  'categories/index'
end

Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: 'sessions#home'

	resource :users

	resource :sessions, only: [:new, :create, :destroy]

	controller :sessions do
		# Get and post request with login routes
		get 'login' => :new
		post 'login' => :create
		# Get delete request with logout route
		get 'logout' => :destroy
	end

	get 'courses/index'

	get 'course_contents/index'

	get 'users/index'

	get 'users/:id', to: 'users#show'

	get 'users/edit/:id', to:'users#edit'

	patch 'users/:id', to:'users#update'

end

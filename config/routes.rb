Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: 'sessions#home'

	resource :users
	resource :courses
	resource :course_contents
	resource :user_courses, except: [:show, :edit, :update]

	resource :sessions, only: [:new, :create, :destroy]

	controller :sessions do
		# Get and post request with login routes
		get 'login' => :new
		post 'login' => :create
		# Get delete request with logout route
		delete 'logout' => :destroy
	end

	get 'courses/index'

	get 'course/:id', to: 'courses#show', :as => :course

	get 'courses/:id/edit', to:'courses#edit', :as => :edit_course

	post 'courses/new', to: 'courses#new', :as => :new_course

	patch 'courses/:id', to:'courses#update'

	delete 'course/:id', to: 'courses#destroy'

	get 'course/:id', to: 'courses#show_user', :as => :show_user

	controller :courses do
		get 'display_course' => :info_course
	end

	get 'courses/:id', to: 'courses#content', :as => :content

	get 'content/new', to: 'courses#new_content', :as => :new_content

	post 'content/new', to: 'courses#create_content'

	get 'content/:id', to: 'courses#edit_content', :as => :edit_content

	patch 'content/:id', to: 'courses#update_content', :as => :update_content

	delete 'content/:id', to: 'courses#destroy_content', :as => :delete_content

	get 'users/index'

	get 'users/:id', to: 'users#show', :as => :user

	get 'users/:id/edit', to:'users#edit', :as => :edit_user

	post 'users/new', to: 'users#new', :as => :new_user

	patch 'users/:id', to:'users#update'

	delete 'users/:id', to: 'users#destroy'

	get 'user_course/new', to: 'user_courses#new', :as => :new_connect

	post 'user_course/new', to: 'user_courses#create'

end

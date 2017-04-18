Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	#Set home root at session home
	root to: 'sessions#home'

	#Getting all resources from users, courses, contents, user courses and sessions
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

	#Course routes

	get 'courses/index'

	get 'course/:id', to: 'courses#show', :as => :course

	get 'courses/:id/edit', to:'courses#edit', :as => :edit_course

	post 'courses/new', to: 'courses#new', :as => :new_course

	patch 'courses/:id', to:'courses#update'

	delete 'course/:id', to: 'courses#destroy'

	get 'course/:id', to: 'courses#show', :as => :show_course

	controller :courses do
		get 'display_course' => :info_course
	end

	#Content routes

	get 'courses/:id', to: 'course_contents#content', :as => :content

	get 'courses/:id/new', to: 'course_contents#new', :as => :new_content

	get 'content/:id', to: 'course_contents#show', :as => :course_content

	get 'contents/:id', to: 'course_contents#edit', :as => :edit_content

	patch 'contents/:id', to: 'course_contents#update', :as => :update_content

	post 'content/:id', to: 'course_contents#destroy'

	#User routes

	get 'users/index'

	get 'users/:id', to: 'users#show', :as => :user

	get 'users/:id/edit', to:'users#edit', :as => :edit_user

	post 'users/new', to: 'users#new', :as => :new_user

	patch 'users/:id', to:'users#update'

	delete 'users/:id', to: 'users#destroy'

	#User course routes

	get 'user_courses', to: 'user_courses#index'

	get 'user_course/new', to: 'user_courses#new', :as => :new_connect

	post 'user_course/new', to: 'user_courses#create'

	get 'user_course/:id', to: 'user_courses#show'

	delete 'user_course/:id', to: 'user_courses#destroy', :as => :user_course

end

module SessionsHelper
	#Login with the user and remember the user if browser was closed
	def log_in(user)
		session[:user_id] = user.id
	end

	#Use current user to collect all of its details and courses
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	#Checked if the user have been logged in, if so, show navigation with 'logout', else 'login'
	def logged_in?
		!current_user.nil?
	end

	#If logout, set current user to nil and delete this session
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

	 #Check if not logged in then go to login page
    def authenticate_user
    	if !logged_in?
        	redirect_to login_url
      	end
    end
end
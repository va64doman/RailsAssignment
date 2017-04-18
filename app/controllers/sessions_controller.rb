class SessionsController < ApplicationController
	def new
	end

	#Login if the username and password's matches are validated, else display error message
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in user
			redirect_to courses_index_url
		else
			flash.now[:alert] = "Invalid email/password combination"
			render 'new'
		end
	end

	#Destroy this page and return to home page
	def destroy
		log_out
  		redirect_to root_path
	end
end
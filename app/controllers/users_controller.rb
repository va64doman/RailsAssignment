class UsersController < ApplicationController
	def index

	end

	def show
	end

	def new

	end

	def create
		
	end

	private
        def set_user
    		@user = User.find(params[:id])
    	end

        def user_params
    		params.require(:user).permit(:name, :email, :password, :password_confirmation)
    	end

    	def authenticate_user
      		if !logged_in?
        		redirect_to login_url
      		end
    	end
end
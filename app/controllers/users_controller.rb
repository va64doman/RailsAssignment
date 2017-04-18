class UsersController < ApplicationController
    #Before proceeding, check if the user has been set or the user does not require authentication
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user

    #Those controller methods are for admin only

    #Display all users details
	def index
        @users = User.all
	end

    #See the users' details
	def show
        @user = User.find(params[:id])
        @title = @user.name
	end

    #Build new users
	def new
        @user = User.new
	end

    #Create new user and return to the user page
	def create
		@user = User.new(user_params)
        if @user.save
            redirect_to user_path(@user), notice: "User has been created successfully."
        else
            render :new
        end
	end

    #Edit the username or password
    def edit
        @user = User.find(params[:id])
    end

    #Update the user's details and return to the user page
    def update
        @user = User.find(params[:id])

        if @user.update(user_params)
            redirect_to user_path(@user), notice: "User has been updated successfully."
        else
            render :edit
        end
    end

    #Delete this user along with the association with the courses
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        
        redirect_to users_index_path, notice: "User has been deleted with relationship."
    end

	private
        #Set user if logged in or forgot to logout
        def set_user
            if @user
    		  @user = User.find(params[:id])
            end
    	end

        #Ensure that user has name, email, two same passwords and admin type
        def user_params
    		params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    	end

        #Check if not logged in then go to login page
    	def authenticate_user
      		if !logged_in?
        		redirect_to login_url
      		end
    	end
end
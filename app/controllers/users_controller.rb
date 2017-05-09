class UsersController < ApplicationController
    #Before proceeding, check if the user has been set or the user does not require authentication
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user
    before_action :check_admin

    #Those controller methods are for admin only

    #Display all users details
	def index
        @users = User.all
	end

    #See the users' details
	def show
        #Add exception for searching details by id
        begin
            @user = User.find(params[:id])
            @title = @user.name
        rescue ActiveRecord::RecordNotFound
            redirect_to users_index_path, alert: "User is not existed."
        end
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
        begin
            @user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            redirect_to users_index_path, alert: "User is not existed."
        end
    end

    #Update the user's details and return to the user page
    def update
        edit()

        if @user.update(user_params)
            redirect_to user_path(@user), notice: "User has been updated successfully."
        else
            render :edit
        end
    end

    #Delete this user along with the association with the courses
    def destroy
        edit()
        @user.destroy
        redirect_to users_index_path, notice: "User has been deleted with relationship."
    end

	private
        #Set user if logged in or forgot to logout
        def set_user
            if @user
    		  edit()
            end
    	end

        #Add security for user
        def check_admin
            if current_user.admin != 3
                redirect_to courses_index_path, alert: "You are not admin!"
            end
        end

        #Ensure that user has name, email, two same passwords and admin type
        def user_params
    		params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    	end
end
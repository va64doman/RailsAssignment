class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user


	def index
        @users = User.all
	end

	def show
        @user = User.find(params[:id])
        @title = @user.name
	end

	def new
        @user = User.new
	end

	def create
		@user = User.new(user_params)
        if @user.save
            redirect_to users_index_path
        else
            render :new
        end
	end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])

        if @user.update(user_params)
            redirect_to users_index_path
        else
            render :edit
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        
        redirect_to users_index_path
    end

	private
        def set_user
            if @user
    		  @user = User.find(params[:id])
            end
    	end

        def user_params
    		params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    	end

    	def authenticate_user
      		if !logged_in?
        		redirect_to login_url
      		end
    	end
end
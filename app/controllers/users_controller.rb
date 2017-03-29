class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user


	def index
        @users = Users.all
	end

	def show
        @user = Users.find(params[:id])
	end

	def new
        @user = Users.new
	end

	def create
		@user = Users.new(user_params)
        if @user.save
            redirect_to users_index_path
        else
            render :new
        end
	end

    def edit
        @user = Users.find(params[:id])
    end

    def update
        @user = Users.find(params[:id])

        if @user.update(tvshow_params)
            redirect_to users_index_path
        else
            render 'edit'
        end
    end

    def destroy
        @user = Users.find(params[:id])
        @user.destroy
        
        redirect_to users_index_path
    end

	private
        def set_user
    		@user = Users.find(params[:id])
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
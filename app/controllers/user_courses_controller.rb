class UserCoursesController < ApplicationController

	def new
		@user_course = UserCourse.new
	end

	def create
		@user_course = UserCourse.new(user_course_params)
        if @user_course.save
        	redirect_to display_course_path
        else
            render :new
        end
	end

	def destroy

	end

	private
        def user_course_params
    		params.require(:user_course).permit(:course_id, user_id:[])
    	end
end
class CoursesController < ApplicationController
	def index
		if current_user.admin == 3
			@courses = Course.all
		else
			@courses = User.includes(:user_courses).includes(:courses)
		end
	end

	def show

	end

	def new
		@course = Course.new
	end

	def create
		@course = Course.new(course_params)
        if @course.save
            redirect_to course_index_path
        else
            render :new
        end
	end

	def edit

	end

	def update

	end

	def destroy

	end

	private
        def course_params
    		params.require(:course).permit(:name, :info, :description, :subject, :study)
    	end
end
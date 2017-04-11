class CoursesController < ApplicationController
	def index
		if current_user.admin == 3
			@courses = Course.all
		else
			@courses = User.includes(:user_courses).includes(:course)
		end
	end

	def info_course
		if current_user.admin == 3
			@courses = Course.all
		else
			@courses = User.includes(:user_courses).includes(:course)
		end
	end

	def show

	end

	def new
		@course = Course.new
		@course.course_contents.build
	end

	def create
		@course = Course.new(course_params)
        if @course.save
            redirect_to display_course_path
        else
            render :new
        end
	end

	def edit
		@course = Course.find(params[:id])
	end

	def update
		@course = Course.find(params[:id])

        if @course.update(course_params)
            redirect_to display_course_path
        else
            render :edit
        end
	end

	def destroy
		@course = Course.find(params[:id])
        @course.destroy
        
        redirect_to display_course_path
	end

	def show_user
		@course = Course.find(params[:id])
	end

	def content
		@course = Course.find(params[:id])
		@contents = @course.course_contents
	end

	def new_content
		@content = CourseContent.new
	end

	def create_content
		@content = CourseContent.new(content_params)
        if @content.save
            redirect_to content_path(@content.course_id)
        else
            render :new_content
        end
	end

	def edit_content
		@content = CourseContent.find(params[:id])
	end

	def update_content
		@content = CourseContent.find(params[:id])

        if @content.update(content_params)
            redirect_to content_path(@content.course_id)
        else
            render :edit_content
        end
	end

	def destroy_content
		@content = CourseContent.find(params[:id])

		@content.destroy
        
        redirect_to course_index_path
	end

	private
        def course_params
    		params.require(:course).permit(:name, :info, :subject, :study,
    			course_contents_attributes: [:name, :description])
    	end

    	def content_params
    		params.require(:course_content).permit(:name, :description, :course_id)
    	end
end
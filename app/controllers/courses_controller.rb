class CoursesController < ApplicationController
	before_action :authenticate_user
	
	#Show all courses based on user's type
	def index
		#If it is an admin, then display all
		if current_user.admin == 3
			@courses = Course.all
		#Else, display the user's courses
		else
			@courses = User.includes(:user_courses).includes(:course)
		end
	end

	#This is for lecturer and admin to see all courses to be enable to modify the course
	def info_course
		#It is similar to index method, except student is not included
		if current_user.admin == 3
			@courses = Course.all
		elsif current_user.admin == 2
			@courses = User.includes(:user_courses).includes(:course)
		else
			redirect_to courses_index_path, alert: "You are not admin/lecturer!"
		end
	end

	#Show the course's details with association with users
	def show
		#Add exception for searching details and security of the courses.
		begin
			@count = 0
			if current_user.admin != 1
				@course = Course.find(params[:id])
				@course.user.each do |user|
					if user = current_user
						@count += 1
					end
				end

				if @count == 0 && current_user.admin == 2
					redirect_to display_course_path, alert: "You have no access to this course."
				end
			else
				redirect_to courses_index_path, alert: "You are not admin/lecturer!"
			end
		rescue ActiveRecord::RecordNotFound
			redirect_to display_course_path, alert: "Course is not existed."
		end
	end

	#Build new course with contents (if applied)
	def new
		if current_user.admin != 1
			@course = Course.new
			@course.course_contents.build
		else
			redirect_to courses_index_path, alert: "You are not admin/lecturer!"
		end
	end

	#Once clicked on 'Create New Course', it will saved based on the course params and return to display course path
	def create
		@course = Course.new(course_params)
        if @course.save
        	#If the current user is a lecturer, it creates a records of a relationship between the new course and user
        	if current_user.admin == 2
        		UserCourse.create(user_id: current_user.id, course_id: @course.id)
        	end

            redirect_to course_path(@course), notice: "Course has been created successfully"
        else
            render :new
        end
	end

	#Edit course's details only, edit content's details is from other page
	def edit
		show()
	end

	#Update course's details
	def update
		show()

        if @course.update(course_params)
            redirect_to course_path(@course), notice: "Course has been updated successfully"
        else
            render :edit
        end
	end

	#Delete the courses and should be enabled to delete all associations with the users
	def destroy
		show()
        @course.destroy
        redirect_to display_course_path, notice: "Course has been deleted with contents and relationship"
	end

	private
		#Course params requires all course's details except description and contents (optional)
        def course_params
    		params.require(:course).permit(:name, :info, :description, :subject, :study,
    			course_contents_attributes: [:name, :description])
    	end
end
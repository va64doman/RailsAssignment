class UserCoursesController < ApplicationController
	before_action :authenticate_user
	before_action :check_admin
	
	#Display all of the associations between the user and course
	def index
		@user_courses = UserCourse.includes(:user, :course).all
	end

	#Display new blank page for creating association with user and course
	def new
		#Set count to 0
		@count = 0
		@user_course = UserCourse.new

		#Collect all users those who are student or lecturer
		@user = []

		User.all.each do |user|
			if user.admin != 3
				@user[@count] = user
				@count += 1
			end
		end
	end

	#For routing purpose, to show all associations based on users' types
	def show
	end

	#Create the relationship between the selected courses and users
	def create
		#If user has not select course or user redirect to new user course and display alert
		if params[:user_course][:course_id].size > 1
			if params[:user_course][:user_id].size > 1
				#Ignore nil in both params, create them into database
				params[:user_course][:course_id].reject(&:blank?).each do |course|
					params[:user_course][:user_id].reject(&:blank?).each do |user|
						#Check to see if the relationship has already exists, otherwise create new relationship.
						if UserCourse.exists?(user_id: user, course_id: course)
							#If exists, alert and return to new connect path
							flash[:alert] = "Invalid! One or more relationships have already exist. Please check associations."
							redirect_to new_connect_path and return
						else
							@user_course = UserCourse.create(:user_id => user, :course_id => course)
						end
					end
				end

        		if @user_course.save
        			redirect_to user_courses_path, notice: "Associations have been created successfully."

        		else
            		render :new
        		end
        	else
        		redirect_to new_connect_path, alert: "Invalid! Must contain at least one course and user"
        	end
        else
        	redirect_to new_connect_path, alert: "Invalid! Must contain at least one course and user"
    	end
	end

	#Destroy the associations and refresh this page
	def destroy
		@user_course = UserCourse.find(params[:id])
        @user_course.destroy
        redirect_to user_courses_path, notice: "Association has been deleted."
	end

	private
		def check_admin
            if current_user.admin == 1
                redirect_to courses_index_path, alert: "You are not admin/lecturer!"
            end
        end
end
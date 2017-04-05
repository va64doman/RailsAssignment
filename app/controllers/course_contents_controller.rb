class CourseContentsController < ApplicationController
	def index
		@contents = User.includes(:user_courses).includes(:courses).includes(:course_contents)
	end

	def show

	end

	def new

	end

	def create

	end

	def edit

	end

	def update

	end

	def destroy

	end
end
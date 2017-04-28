module CourseContentHelper
	def option_for_set_course
		options_for_select([[@course.name, @course.id]])
	end

	def set_course
		@course.id
	end
end
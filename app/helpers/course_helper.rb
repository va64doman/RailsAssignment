module CourseHelper
	def option_for_study
		options_for_select([["Full Time", "Full Time"], ["Part Time", "Part Time"], ["Online Study", "Online Study"]])
	end
end
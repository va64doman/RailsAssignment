module UserHelper
	def option_for_admin
		options_for_select([["Student", 1], ["Lecturer", 2], ["Admin", 3]])
	end
end

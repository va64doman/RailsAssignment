class CourseContent < ApplicationRecord
	belongs_to :courses, optional: true
end

class CourseContent < ApplicationRecord
	validates :name, :description, presence: true

	#Many contents belong to one of the course
	belongs_to :course, optional: true
end

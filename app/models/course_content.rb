class CourseContent < ApplicationRecord
	validates :name, :description, presence: true
	belongs_to :course, optional: true
end

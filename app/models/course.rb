class Course < ApplicationRecord
	validates :name, :info, :description, :subject, :study, presence: true
	belongs_to :user_courses, optional: true
	has_many :course_contents
end
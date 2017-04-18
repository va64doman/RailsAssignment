class Course < ApplicationRecord
	validates :name, :info, :description, :subject, :study, presence: true

	#Any records that related with course except users are destroy
	#Course has many user courses, users through user courses and course contents
	has_many :user_courses, dependent: :destroy
	has_many :user, through: :user_courses
	has_many :course_contents, dependent: :destroy

	#Course should allows to destroy the contents
	accepts_nested_attributes_for :course_contents, allow_destroy: true
end
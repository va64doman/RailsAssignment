class Course < ApplicationRecord
	validates :name, :info, :description, :subject, :study, presence: true

	has_many :user_courses
	has_many :user, through: :user_courses
	has_many :course_contents

	accepts_nested_attributes_for :course_contents, allow_destroy: true
end
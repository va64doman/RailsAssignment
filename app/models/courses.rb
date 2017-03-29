class Course < ApplicationRecord
	validates :name, :info, :description, :subject, :type, presence: true
	belongs_to :users_courses, optional: true
end
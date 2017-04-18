class UserCourse < ApplicationRecord
	#User courses belongs to many users and courses to formed a relation table
	belongs_to :user, optional: true
	belongs_to :course, optional: true
end
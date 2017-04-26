class UserCourse < ApplicationRecord
	#User courses belongs to many users and courses to formed a relation table
	belongs_to :user, optional: true
	belongs_to :course, optional: true
	delegate :name, :to => :user, :prefix => true
	delegate :name, :to => :course, :prefix => true
end
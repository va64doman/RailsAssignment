class User < ApplicationRecord
	validates :name, presence: true

	#Write the email address in this format without case sensitive to identify easier
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
		format: { with: VALID_EMAIL_REGEX }, 
		uniqueness: { case_sensitive: false }

	#Require secure password
	has_secure_password
	validates :password, presence: true, length: { minimum: 8 }


	#User has many courses through user course and has many user courses
	has_many :user_courses, dependent: :destroy #Destroy all relationship with users
	has_many :course, through: :user_courses
end
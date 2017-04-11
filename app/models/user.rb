class User < ApplicationRecord
	validates :name, presence: true

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
		format: { with: VALID_EMAIL_REGEX }, 
		uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, presence: true, length: { minimum: 8 }

	has_many :user_courses
	has_many :course, through: :user_courses
end
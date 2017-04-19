require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
		# test "the truth" do
		#   assert true
		# end
		#Check if the client enables to search for user, raise assert if error occurred
		test "Should be able to find user" do
			user = User.find(9)
			puts "Username: #{user.name}"

			assert_raise ActiveRecord::RecordNotFound do
				User.find(1)
			end
		end

		#Check if the user is saved providing all of information
		test "Should be able to create user with all details" do
			user = User.create(:name => "Person", :email => "person@example.com", :password => "pass1234", :password_confirmation => "pass1234", :admin => 3)
			assert user.save
		end

		#Check if the user is editable, display two different user's names
		test "Should be able to update user" do
			user = User.find(9)
			puts user.name
			user.update(:name => "Name")
			puts user.name
		end

		#Check if user can be delete
		test "Should be able to delete user" do
			user = User.find(9)
			user.destroy

			if User.exists?(user.id)
				puts "User has not destroyed."
			else
				puts "User has been destroyed."
			end

			assert user.destroy
		end
end

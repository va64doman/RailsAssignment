require 'test_helper'

class UserCourseControllerTest < ActionDispatch::IntegrationTest
	# test "the truth" do
		# assert true
	# end

	#Test that the relationship can be build and ensure to show the relation's user id and course id
	test "Create relationship" do
		user = User.find(9)
		course = Course.find(10)
		relation = UserCourse.create(:user_id => user.id, :course_id => course.id)
		assert relation.save
		assert !relation.blank?
		puts "User ID: #{relation.user_id}"
		puts "Course ID: #{relation.course_id}"
	end

	#Ensure that only the relationship is remove, check if the user and course still existed.
	test "Delete Relationship Only" do
		relation = UserCourse.find(5)
		user = relation.user_id
		course = relation.course_id

		relation.destroy

		if UserCourse.exists?(relation.id)
			puts "Relationship has not destroyed."
		else
			puts "Relationship has been destroyed."
		end

		if User.exists?(user)
			puts "User has not destroyed."
		else
			puts "User has been destroyed but it should not be."
		end

		if Course.exists?(course)
			puts "Course has not destroyed."
		else
			puts "Course has been destroyed but it should not be."
		end

	end

	#Check if the user delete and the relationship with user also delete
	test "Delete User/Course with Relationship" do
		user = User.find(9)
		relation = UserCourse.find_by_user_id(9)
		user.destroy

		assert !relation.blank?
	end	
end
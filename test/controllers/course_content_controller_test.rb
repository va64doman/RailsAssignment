require 'test_helper'

class UserCourseControllerTest < ActionDispatch::IntegrationTest
	# test "the truth" do
		# assert true
	# end

	#Check to see if user can create new content for this course
	test "Create Content Related To Course" do
		course = Course.find(10)
		content = CourseContent.create(:name => "Content", :description => "Description", :course_id => course.id)
		assert content.save
		assert !content.blank?
		puts "Content Course ID: #{content.course_id}."
		assert !course.course_contents.blank?
	end
end
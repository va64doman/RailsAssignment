require 'test_helper'

class CourseControllerTest < ActionDispatch::IntegrationTest
		# test "the truth" do
		#   assert true
		# end

		#Test to see if the user can create course without contents
		test "Create course without contents" do
			course = Course.create(:name => "Course", :info => "Info", :description => "Description", :subject => "Subject", :study => "Full-Time")
			assert course.save
		end

		#Check to see if the user has create course and content, check if content is not empty
		test "Create course with contents" do
			course = Course.create(:name => "Course", :info => "Info", :description => "Description", :subject => "Subject", :study => "Full-Time", 
				course_contents_attributes: [:name => "Contents", :description => "Description"])
			assert course.save
			content = course.course_contents
			assert !content.blank?
		end
end